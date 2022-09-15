//
//  NewNoteValidationUnitTests.swift
//  CompositionalLayoutExerciseTests
//
//  Created by Abhishek Dhiman on 15/09/22.
//

import XCTest
@testable import CompostionalLayoutExercise

class NewNoteValidationUnitTests: XCTestCase {

    func test_NewNoteValidation_With_EmptyTitle_Returns_ValidationFailure() {
        
       // Arrange
        let validation = NewNoteValidation()
        let request = Note(id: UUID(), title: "", image: nil, description: "this for test purpose", creationDate: Date(), imageData: nil)
        
        // Act
        let result = validation.validateNewNoteInfo(with: request)
        
        // Assert
        XCTAssertFalse(result.success)
        XCTAssertNotNil(result.message)
        XCTAssertEqual(result.message, "Note Title can't be left empty.")
    }
    
    func test_NewNoteValidation_With_EmptyDescription_Returns_ValidationFailure() {
        
       // Arrange
        let validation = NewNoteValidation()
        let request = Note(id: UUID(), title: "test", image: nil, description: "", creationDate: Date(), imageData: nil)
        
        // Act
        let result = validation.validateNewNoteInfo(with: request)
        
        // Assert
        XCTAssertFalse(result.success)
        XCTAssertNotNil(result.message)
        XCTAssertEqual(result.message, "Note Description can't be left empty.")
    }

}
