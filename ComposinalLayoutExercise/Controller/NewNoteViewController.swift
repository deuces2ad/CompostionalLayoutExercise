//
//  AddNewNoteViewController.swift
//  ComposinalLayoutExercise
//
//  Created by Abhishek Dhiman on 11/09/22.
//

import UIKit
import Combine

class NewNoteViewController : UIViewController {
    
    //MARK: - Private Variables
    private var cancellable = Set<AnyCancellable>()
    private var userSelectedNoteImage : UIImage?
    private let addNewNoteViewModel = NoteViewModel()
    private let noteManager = NoteManager()
    
    @Published var newNoteListener : NoteInformation?

    //MARK: - View Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        updateNavBarProperties()
        registerListeners()
    }
    
    override func loadView() {
        super.loadView()
        view = rootView
    }
    
   //MARK: - Properties
    private lazy var rootView : AddNewNoteRootView = {
        let rootView = AddNewNoteRootView()
        rootView.backgroundColor = AppThemeColor.themeBlackColor.value
        return rootView
    }()
    
    private lazy var imagePicker: ImagePicker = {
           let imagePicker = ImagePicker()
           imagePicker.delegate = self
           return imagePicker
       }()
    
    //MARK: - Private Methods
    private func updateNavBarProperties() {
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.isHidden = true
    }
    
    private func registerListeners() {
        
        ///Button Listener
        rootView.backButtonListener.sink { [weak self] _ in
            self?.popViewController()
        }.store(in: &cancellable)
        
        ///ImagePicker Button Listener
        rootView.imagePickerListener.sink { [weak self] _ in
         self?.imagePicker.photoGalleryAccessRequest()
        }.store(in: &cancellable)
        
        ///SaveNote Button Listener
        rootView.saveNoteListener.sink { [weak self] _ in
            guard let self = self else { return }
            
            let newNoteInfo = self.toNoteInformation(with:self.userSelectedNoteImage)
                
                if  let errorMessage = self.addNewNoteViewModel.validateNote(with: newNoteInfo){
                    self.showAlert(with: UIConstant.alertTitle, message: errorMessage)
                }else {
                    self.newNoteListener = newNoteInfo
                    self.noteManager.createNote(note: newNoteInfo)
                    self.popViewController()
                }

        }.store(in: &cancellable)
    }
    
    private func popViewController() {
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.popViewController(animated: true)
    }
    
    func toNoteInformation(with image : UIImage?) -> NoteInformation{
        
        let noteTitle = rootView.newNoteTitleTextView.text ?? AppConstant.EMPTY_STRING
        let noteDescription = rootView.newNoteDescriptionTextView.text ?? AppConstant.EMPTY_STRING
        let noteImage = image?.pngData()
        return NoteInformation(id: UUID(),
                               noteTitle: noteTitle,
                               noteImage: noteImage,
                               noteDescription: noteDescription,
                               noteCreationDate: Date())
    }
    
   
}
//MARK: - ImagePicker Delegate Method
extension NewNoteViewController : ImagePickerDelegate {
    
    func imagePicker(_ imagePicker: ImagePicker, didSelect image: UIImage) {
        self.userSelectedNoteImage = image
        print(image)
        imagePicker.dismiss()
    }
    
    func cancelButtonDidClick(on imageView: ImagePicker) { imagePicker.dismiss() }
    func imagePicker(_ imagePicker: ImagePicker, grantedAccess: Bool,
                     to sourceType: UIImagePickerController.SourceType) {
        guard grantedAccess else { return }
        imagePicker.present(parent: self, sourceType: sourceType)
    }
}

extension UIViewController {
    func showAlert(with title : String, message:String){
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default){_ in
            self.dismiss(animated: true)
        }
        alert.addAction(action)
        self.present(alert, animated: true)
    }
}