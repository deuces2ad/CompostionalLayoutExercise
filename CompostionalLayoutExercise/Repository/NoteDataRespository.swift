//
//  NoteDataRepository.swift
//  CompositionalLayoutExercise
//
//  Created by Abhishek Dhiman on 13/09/22.
//

import Foundation
import CoreData

protocol NoteRepository: AnyObject {
    func save(note: Note) -> Bool
    func saveNotes(notes: Array<Note>) -> Bool
    func getAll() -> [Note]?
    func get(byIdentifier id : UUID) -> Note?
}

class NoteDataRepository: NoteRepository {
    
    func save(note: Note) -> Bool {
        let cdNote = CDNote(context: PersistenceStorage.shared.context)
        cdNote.id = note.id
        cdNote.noteTitle = note.title
        cdNote.noteDescription = note.description
        cdNote.noteImage = note.imageData
        cdNote.noteImageUrl = note.image
        cdNote.noteCreationDate = note.creationDate
        
        return PersistenceStorage.shared.saveContext()
    }
    
    func saveNotes(notes: Array<Note>) -> Bool {
        
        for note in notes {
            let cdNote = CDNote(context: PersistenceStorage.shared.context)
            cdNote.id = note.id
            cdNote.noteTitle = note.title
            cdNote.noteDescription = note.description
            cdNote.noteImage = note.imageData
            cdNote.noteImageUrl = note.image
            cdNote.noteCreationDate = note.creationDate
        }
        
        return PersistenceStorage.shared.saveContext()
    }
    
    func getAll() -> [Note]? {
        let result = PersistenceStorage.shared.fetchManagedObject(managedObject: CDNote.self)
        var notes : [Note] = []
        result?.forEach({ cdNote in
            notes.append(cdNote.convertToNote())
        })
        return notes
    }
    
    func get(byIdentifier id: UUID) -> Note? {
        let result = getNote(byIdentifier: id)
        guard result != nil else {return nil}
        return result?.convertToNote()
    }
    
    func getNote(byIdentifier id : UUID)-> CDNote? {
        let fetchRequest  = NSFetchRequest<CDNote>(entityName: "CDNote")
        let sortDescriptor  = NSSortDescriptor(key: "noteCreationDate", ascending: false)
        fetchRequest.sortDescriptors = [sortDescriptor]
        let predicate = NSPredicate(format: "@id==%@", id as CVarArg)
        fetchRequest.predicate = predicate
        do {
            let result = try PersistenceStorage.shared.context.fetch(fetchRequest).first
            guard result != nil else  {return nil}
            return result
        } catch let error {
            print("ERROR",error)
        }
        return nil
    }
}
