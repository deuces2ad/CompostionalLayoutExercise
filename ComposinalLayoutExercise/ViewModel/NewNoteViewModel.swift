//
//  NoteViewModel.swift
//  ComposinalLayoutExercise
//
//  Created by Abhishek Dhiman on 12/09/22.
//


import UIKit

class NewNoteViewModel {
        
    func validateNote(with info : NoteInformation) -> NewNoteValidationResult {
        return NewNoteValidation().validateNewNoteInfo(with: info)
    }
}

