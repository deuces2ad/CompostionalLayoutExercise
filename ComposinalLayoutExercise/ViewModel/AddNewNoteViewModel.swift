//
//  AddNewNoteViewModel.swift
//  ComposinalLayoutExercise
//
//  Created by Abhishek Dhiman on 12/09/22.
//

import Foundation
import UIKit

class AddNewNoteViewModel  {
    
    func isNewNoteCreated(with info : NoteInformation) -> String? {
        let newNoteValidationResult = NewNoteValidation().validateNewNoteInfo(with: info)
        if newNoteValidationResult.success {
            print("Valid Note with info",info)
        }else{
            if let error = newNoteValidationResult.message {
                return error
            }
        }
        return nil
    }
    
     func createNewNote(with rootView : AddNewNoteRootView? , for image : UIImage?) -> NoteInformation{
        let noteTitle = rootView?.newNoteTitleTextView.text ?? ""
        let noteDescription = rootView?.newNoteDescriptionTextView.text ?? ""
        let noteImage = image?.jpegData(compressionQuality: 0.5)
        return NoteInformation(id: UUID(),
                               noteTitle: noteTitle,
                               noteImage: noteImage,
                               noteDescription: noteDescription,
                               noteCreationDate: Date())
    }
}
