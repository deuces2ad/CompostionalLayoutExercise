//
//  NoteRepositoryTest.swift
//  CompostionalLayoutExerciseTests
//
//  Created by Abhishek Dhiman on 16/09/22.
//

import XCTest
@testable import CompostionalLayoutExercise

final class NoteRepositoryTest: XCTestCase {
    
    var persistenceProvider : PersistenceStorage!
    var noteRepository : NoteDataAccessorProtocol!
    
    override func setUp() {
        super.setUp()
        persistenceProvider = PersistenceStorage.init(storageType: .inMemory)
        noteRepository = DataAccessorFactory().createNoteDataAccessor()
    }
    
    func test_Create_Note_Return_Success() {
        
        // ARRANGE
        let noteDatail = Note(id: UUID(),
                              title: "this is test note title",
                              image: nil,
                              description: "this is a test description",
                              creationDate: Date.now,
                              imageData: nil)
        
        let result = noteRepository.saveNote(note: noteDatail)
        
        // ACT
        let fetchedNote = noteRepository.fetchNote()
        var noteTitle : String {
            for note in fetchedNote! where note.title == "this is test note title" {
                return note.title
            }
            return ""
        }
        // ASSERT
        XCTAssertTrue(result)
        XCTAssertEqual(noteTitle, "this is test note title")
    }
}
