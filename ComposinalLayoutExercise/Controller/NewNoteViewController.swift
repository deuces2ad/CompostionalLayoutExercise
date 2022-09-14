//
//  AddNewNoteViewController.swift
//  ComposinalLayoutExercise
//
//  Created by Abhishek Dhiman on 11/09/22.
//

import UIKit

class NewNoteViewController : UIViewController {
    
    //MARK: - Private Variables
    private var userSelectedNoteImage : UIImage?
    private let addNewNoteViewModel = NewNoteViewModel()
    private let noteManager = NoteManager()
    
    var newNoteListener : ((NoteInformation)->Void)? = nil

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
    
    //MARK: - Methods
    private func registerListeners() {
        ///Button Listener
        rootView.backButtonListener = { [weak self] in
            self?.popViewController()
        }
        
        ///ImagePicker Button Listener
        rootView.imagePickerListener = { [weak self] in
         self?.imagePicker.photoGalleryAccessRequest()
        }
        
        ///SaveNote Button Listener
        rootView.saveNoteListener = { [weak self]  in
            guard let self = self else { return }
            let newNoteInfo = self.toNoteInformation(with:self.userSelectedNoteImage)
            self.saveToLocalDataBase(for: newNoteInfo)
        }
    }
    
    private func popViewController() {
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.popViewController(animated: true)
    }
    
    private func toNoteInformation(with image : UIImage?) -> NoteInformation{
        let noteTitle = rootView.newNoteTitleTextView.text ?? AppConstant.EMPTY_STRING
        let noteDescription = rootView.newNoteDescriptionTextView.text ?? AppConstant.EMPTY_STRING
        let noteImage = image?.jpegData(compressionQuality: 1.0)
        return NoteInformation(id: UUID(),
                               noteTitle: noteTitle,
                               noteImage: nil,
                               noteDescription: noteDescription,
                               noteCreationDate: Date(),
                               noteImageData: noteImage)
    }
    
    private func saveToLocalDataBase(for note :NoteInformation) {
        let result = addNewNoteViewModel.validateNote(with: note)
        if result.success == true {
            self.newNoteListener?(note)
            self.popViewController()
        }else{
            self.showAlert(with: UIConstant.alertTitle, message: result.message ?? AppConstant.EMPTY_STRING)
        }
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
