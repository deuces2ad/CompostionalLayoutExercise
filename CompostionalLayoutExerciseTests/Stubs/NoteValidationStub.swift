//
//  NoteViewModelTest.swift
//  CompostionalLayoutExerciseTests
//
//  Created by Abhishek Dhiman on 16/09/22.
//

import Foundation
@testable import CompostionalLayoutExercise

class NoteValidationStub: NoteValidationProtocol {
    
    private let success: Bool
    private let errorMessage: String?
    
    init(success:Bool, errorMessage: String?){
        self.success = success
        self.errorMessage = errorMessage
    }
    
    func validate(note: Note) -> ValidationResult {
        return ValidationResult(success: success, errorMessage: errorMessage)
    }
}
