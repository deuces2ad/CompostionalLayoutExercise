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
    
    func createNote(note : NoteInformation) {
        noteInformationRepository.create(note: note)
    }
    
    func fetchNote() -> [NoteInformation]? {
       return  noteInformationRepository.getAll()
    }
    
    func fetchNoteById(byIdentifier id: UUID) -> NoteInformation? {
        return noteInformationRepository.get(byIdentifier: id)
    }
    
    func updateNote(note: NoteInformation) -> Bool {
        return noteInformationRepository.update(note: note)
    }
    
    func deleteNote(note: NoteInformation) -> Bool {
        return noteInformationRepository.delete(record: note)
    }
}
