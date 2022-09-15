//
//  NoteManager.swift
//  CompositionalLayoutExercise
//
//  Created by Abhishek Dhiman on 13/09/22.
//

import Foundation

protocol NoteDataAccessorProtocol {
    func saveNote(note : Note) -> Bool
    func saveNotes(notes: Array<Note>) -> Bool
    func fetchNote() -> Array<Note>?
    func fetchNoteById(byIdentifier id: UUID) -> Note?
}

class NoteDataAccessor: NoteDataAccessorProtocol {
    
    private var noteRepository: NoteRepository = NoteRepositoryFactory().createNoteRepository()
    
    func saveNote(note : Note) -> Bool {
       return noteRepository.save(note: note)
    }
    
    func saveNotes(notes: Array<Note>) -> Bool {
        return noteRepository.saveNotes(notes: notes)
    }
    
    func fetchNote() -> Array<Note>? {
       return noteRepository.getAll()
    }
    
    func fetchNoteById(byIdentifier id: UUID) -> Note? {
        return noteRepository.get(byIdentifier: id)
    }
}
