//
//  NoteDataRespository.swift
//  ComposinalLayoutExercise
//
//  Created by Abhishek Dhiman on 13/09/22.
//

import Foundation
import CoreData


protocol NoteRespository {
    
    func create(note: Note)
    func getAll() -> [Note]?
    func get(byIdentifier id : UUID) -> Note?
    func update(note: Note) -> Bool
    func delete(record: Note) -> Bool
}

struct NoteInformationRepository : NoteRespository {
    
    func create(note: Note) {
        let cdNote = CDNote(context: PersistenceStorage.shared.context)
        cdNote.noteTitle = note.title
        cdNote.noteDescription = note.description
        cdNote.noteImage = note.imageData
        cdNote.noteImageUrl = note.image
        cdNote.noteCreationDate = note.creationDate
        PersistenceStorage.shared.saveContext()
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
    
    func update(note: Note) -> Bool {
        let cdNote = getNote(byIdentifier: note.id)
        guard cdNote != nil else {return false}
         
        cdNote?.noteTitle = note.title
        cdNote?.noteDescription = note.description
        cdNote?.noteImage = note.imageData
        PersistenceStorage.shared.saveContext()
        return true
    }
    
    func delete(record: Note) -> Bool {
        let cdNote = getNote(byIdentifier: record.id)
        guard cdNote != nil else {return false}
        PersistenceStorage.shared.context.delete(cdNote!)
        return true 
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
