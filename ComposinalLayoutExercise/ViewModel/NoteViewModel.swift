//
//  NoteViewModel.swift
//  ComposinalLayoutExercise
//
//  Created by Abhishek Dhiman on 12/09/22.
//


import UIKit

class NoteViewModel {
    
    func validateNote(with info : NoteInformation) -> String? {
        let newNoteValidationResult = NewNoteValidation().validateNewNoteInfo(with: info)
        if newNoteValidationResult.success {
            print("Valid Note with info",info)
        }else {
            if let error = newNoteValidationResult.message {
                return error
            }
        }
        return nil
    }
}
