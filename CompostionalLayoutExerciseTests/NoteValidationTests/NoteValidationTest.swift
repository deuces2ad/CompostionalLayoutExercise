//
//  NoteValidationTest.swift
//  CompositionalLayoutExerciseTests
//
//  Created by Abhishek Dhiman on 15/09/22.
//

import XCTest
@testable import CompostionalLayoutExercise

class NoteValidationTest: XCTestCase {
    
    func test_Validate_With_EmptyTitle_Returns_Failure() {
        
        // ARRANGE
        let noteValidation = createNoteValidation()
        let noteToAdd = createNote(title: AppConstant.emptyString, description: "test description")
        
        // ACT
        let result = noteValidation.validate(note: noteToAdd)
        
        // ASSERT
        XCTAssertNotNil(result.errorMessage)
        XCTAssertEqual(ValidationConstant.emptyTitle,result.errorMessage)
        XCTAssertFalse(result.success)
    }
    
    func test_Validate_With_EmptyDescription_Returns_Failure() {
        
        // ARRANGE
        let noteValidation = createNoteValidation()
        let noteToAdd = createNote(title: "test title", description: AppConstant.emptyString)
        
        // ACT
        let result = noteValidation.validate(note: noteToAdd)
        
        // ASSERT
        XCTAssertNotNil(result.errorMessage)
        XCTAssertEqual(ValidationConstant.emptyDescription, result.errorMessage)
        XCTAssertFalse(result.success)
    }
    
    func test_NewNoteValidation_With_Invalid_Note_Returns_Faliure() {
        
        // ARRANGE
        let noteValidation = createNoteValidation()
        let noteToAdd = createNote(title: AppConstant.emptyString, description: AppConstant.emptyString)
        
        // ACT
        let result = noteValidation.validate(note: noteToAdd)
        
        // ASSERT
        XCTAssertNotNil(result.errorMessage)
        XCTAssertEqual(ValidationConstant.emptyTitle,result.errorMessage)
        XCTAssertFalse(result.success)
    }
    
    func test_Validate_With_Valid_Note_Returns_Success() {
        
        // ARRANGE
        let noteValidation = createNoteValidation()
        let noteToAdd = createNote(title: "test title", description: "test description")
        
        // ACT
        let result = noteValidation.validate(note: noteToAdd)
        
        // ASSERT
        XCTAssertNil(result.errorMessage)
        XCTAssertTrue(result.success)
    }
    
    //MARK: - Private methods
    private func createNoteValidation() -> NoteValidation {
        return NoteValidation()
    }
    
    private func createNote(title: String, description: String) -> Note {
        return  Note(id: UUID(), title: title, image: nil, description: description, creationDate: Date(), imageData: nil)
    }
}
