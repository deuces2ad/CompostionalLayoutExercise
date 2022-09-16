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
        
        // ARRANGE
        let viewModel = NewNoteViewModel()
        let note = Note(id: UUID(), title: "", image: nil, description: "", creationDate: Date(), imageData: nil)
        
        // ACT
        let result = viewModel.validateNote(with: note)
        
        // ASSERT
        XCTAssertFalse(result.success)
        XCTAssertNotNil(result.message)
        XCTAssertEqual(result.message, "Note Title can't be left empty.")
    }
    
    func test_NewNoteValidation_With_EmptyDescription_Returns_ValidationFailure() {
        
        // ARRANGE
        let viewModel = NewNoteViewModel()
        let note = Note(id: UUID(), title: "title", image: nil, description: "", creationDate: Date(), imageData: nil)
        
        // ACT
        let result = viewModel.validateNote(with: note)
        
        // ASSERT
        XCTAssertFalse(result.success)
        XCTAssertNotNil(result.message)
        XCTAssertEqual(result.message, "Note Description can't be left empty.")
    }
    
    func test_NewNoteValidation_With_Valid_Title_and_Empty_Description_Returns_ValidationFailure() {
        
        // ARRANGE
        let viewModel = NewNoteViewModel()
        let note = Note(id: UUID(), title: "test", image: nil, description: "", creationDate: Date(), imageData: nil)
        
        // ACT
        let result = viewModel.validateNote(with: note)
        
        // ASSERT
        XCTAssertFalse(result.success)
        XCTAssertNotNil(result.message)
        XCTAssertEqual(result.message, "Note Description can't be left empty.")
        
    }
    
    func test_NewNoteValidation_With_Empty_Title_and_Valid_Description_Returns_ValidationFaliure() {
        
        // ARRANGE
        let viewModel = NewNoteViewModel()
        let note = Note(id: UUID(), title: "", image: nil, description: "test description", creationDate: Date(), imageData: nil)
        
        // ACT
        let result = viewModel.validateNote(with: note)
        
        // ASSERT
        XCTAssertFalse(result.success)
        XCTAssertNotNil(result.message)
        XCTAssertEqual(result.message, "Note Title can't be left empty.")
        
    }
    
    func test_NewNoteValidation_With_Valid_Title_and_Valid_Description_Returns_Success() {
        
        // ARRANGE
        let viewModel = NewNoteViewModel()
        let note = Note(id: UUID(), title: "test", image: nil, description: "test description", creationDate: Date(), imageData: nil)
        
        // ACT
        let result = viewModel.validateNote(with: note)
        
        // ASSERT
        XCTAssertTrue(result.success)
        XCTAssertNil(result.message)
    }
}
