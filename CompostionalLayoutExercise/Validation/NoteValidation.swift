//
//  NewNoteValidation.swift
//  CompositionalLayoutExercise
//
//  Created by Abhishek Dhiman on 12/09/22.
//

import Foundation

protocol NoteValidationProtocol {
    func validate(note: Note) -> ValidationResult
}

class NoteValidation: NoteValidationProtocol {
    
    func validate(note: Note) -> ValidationResult {
        
        if note.title.isEmpty {
            return ValidationResult(success: false, errorMessage: ValidationConstant.emptyTitle)
        }
        if note.description.isEmpty {
            return ValidationResult(success: false, errorMessage: ValidationConstant.emptyDescription)
        }
        return ValidationResult(success: true, errorMessage: nil)
    }
}
