//
//  NoteViewModelTest.swift
//  CompostionalLayoutExerciseTests
//
//  Created by Abhishek Dhiman on 16/09/22.
//

import Foundation
@testable import CompostionalLayoutExercise

class NoteDataAccessorValidStub: NoteDataAccessorProtocol {
    
    func saveNote(note : Note) -> Bool {
        return true
    }
    
    func saveNotes(notes: Array<Note>) -> Bool {
        return true
    }
    
    func fetchNote() -> Array<Note>? {
        return stubNotesFromStorage()
    }
    
    func fetchNoteById(byIdentifier id: UUID) -> Note? {
        return Note(id: id, title: "test title", image: nil, description: "test description", creationDate: Date(), imageData: nil)
    }
    
    private func stubNotesFromStorage() -> [Note] {
        return  [Note(id: UUID(), title: "test title", image: nil, description: "test description", creationDate: Date(), imageData: nil),
                 Note(id: UUID(), title: "Another test title ", image: nil, description: "Another test description", creationDate: Date(), imageData: nil)]
    }
}

class NoteDataAccessorInValidStub: NoteDataAccessorProtocol {
    
    private var noteRepository: NoteRepository = NoteRepositoryFactory().createNoteRepository()
    
    func saveNote(note : Note) -> Bool {
        return false
    }
    
    func saveNotes(notes: Array<Note>) -> Bool {
        return false
    }
    
    func fetchNote() -> Array<Note>? {
        return nil
    }
    
    func fetchNoteById(byIdentifier id: UUID) -> Note? {
        return nil
    }
}
