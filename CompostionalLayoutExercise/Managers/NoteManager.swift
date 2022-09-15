//
//  NoteManager.swift
//  ComposinalLayoutExercise
//
//  Created by Abhishek Dhiman on 13/09/22.
//

import Foundation
import CoreData

struct NoteManager {
    
    private let noteInformationRepository = NoteInformationRepository()
    
    func createNote(note : Note) {
        noteInformationRepository.create(note: note)
    }
    
    func fetchNote() -> [Note]? {
       return  noteInformationRepository.getAll()
    }
    
    func fetchNoteById(byIdentifier id: UUID) -> Note? {
        return noteInformationRepository.get(byIdentifier: id)
    }
    
    func updateNote(note: Note) -> Bool {
        return noteInformationRepository.update(note: note)
    }
    
    func deleteNote(note: Note) -> Bool {
        return noteInformationRepository.delete(record: note)
    }
}
