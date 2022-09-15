//
//  NewNoteValidation.swift
//  CompositionalLayoutExercise
//
//  Created by Abhishek Dhiman on 12/09/22.
//

import Foundation


struct NewNoteValidation {
    
    func validateNewNoteInfo(with info:Note) -> NewNoteValidationResult {
        if info.title.isEmpty {
            return NewNoteValidationResult(success: false, message: "Note Title can't be left empty.")
        }
        if info.description.isEmpty {
            return NewNoteValidationResult(success: false, message: "Note Description can't be left empty.")
        }
        return NewNoteValidationResult(success: true, message: nil)
    }
}

struct NewNoteValidationResult {
    let success : Bool
    let message : String?
}
