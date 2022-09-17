//
//  AddNewNoteViewController.swift
//  CompositionalLayoutExercise
//
//  Created by Abhishek Dhiman on 11/09/22.
//

import UIKit

class NewNoteViewController : UIViewController {
    
    //MARK: - Private Variables
    private var userSelectedNoteImage : UIImage?


    var newNoteListener : ((Note)->Void)? = nil

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
        rootView.backgroundColor = ApplicationColor.darkBackground
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
//        self.navigationController?.navigationBar.isHidden = false
//        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.popViewController(animated: true)
    }
    
    private func toNoteInformation(with image : UIImage?) -> Note{
        let noteTitle = rootView.newNoteTitleTextView.text ?? AppConstant.emptyString
        let noteDescription = rootView.newNoteDescriptionTextView.text ?? AppConstant.emptyString
        let noteImage = image?.jpegData(compressionQuality: 1.0)
        return Note(id: UUID(),
                               title: noteTitle,
                               image: nil,
                               description: noteDescription,
                               creationDate: Date(),
                               imageData: noteImage)
    }
    
    private func saveToLocalDataBase(for note :Note) {
        self.newNoteListener?(note)
        self.popViewController()
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
