//
//  NoteViewModelTest.swift
//  CompostionalLayoutExerciseTests
//
//  Created by Abhishek Dhiman on 16/09/22.
//

import XCTest
@testable import CompostionalLayoutExercise

class NoteViewModelTest: XCTestCase {
    
    func test_GetNotes_FromService_Returns_NotesCollection() {
        
        // ARRANGE
        let noteViewModel = NoteViewModelTestDouble(savesNote: true, isNotesSynced: false)
        
        // ACT
        noteViewModel.getNotes { notes in
            // ASSERT
            XCTAssertNotNil(notes)
            XCTAssertFalse(notes!.isEmpty)
        }
    }
    
    func test_GetNotes_FromStorage_Returns_NotesCollection() {
        // ARRANGE
        let noteViewModel = NoteViewModelTestDouble(savesNote: false, isNotesSynced: true)
        
        // ACT
        noteViewModel.getNotes { notes in
            // ASSERT
            XCTAssertNotNil(notes)
            XCTAssertFalse(notes!.isEmpty)
        }
    }
    
    func test_SaveNote_WithValidNote_Returns_Success() {
        
        // ARRANGE
        let noteToSave = createValidNote()
        let noteViewModel = NoteViewModelTestDouble(isValidNote: true)
        
        //ACT
        let result = noteViewModel.saveNote(note: noteToSave)
        
        //ASSERT
        XCTAssertTrue(result.isSaved)
        XCTAssertNil(result.errorMessage)
    }
    
    func test_SaveNote_WithInvalidNote_Returns_Failure() {
        
        // ARRANGE
        let noteViewModel = NoteViewModelTestDouble(isValidNote: false)
        let noteToSave = createInValidNote()
        
        //ACT
        let result = noteViewModel.saveNote(note: noteToSave)
        
        //ASSERT
        XCTAssertFalse(result.isSaved)
        XCTAssertNotNil(result.errorMessage)
        //XCTAssertEqual(ValidationConstant.emptyTitle, result.errorMessage)
    }
    
    // MARK: Private Methods
    private func createValidNote() -> Note {
        return Note(id: UUID(), title: "test title", image: nil, description: "test description", creationDate: Date(), imageData: nil)
    }
    
    private func createInValidNote() -> Note {
        return Note(id: UUID(), title: AppConstant.emptyString, image: nil, description: AppConstant.emptyString, creationDate: Date(), imageData: nil)
    }
}
