//
//  NoteDataRespository.swift
//  ComposinalLayoutExercise
//
//  Created by Abhishek Dhiman on 13/09/22.
//

import Foundation
import CoreData


protocol NoteRespository {
    
    func create(note: NoteInformation)
    func getAll() -> [NoteInformation]?
    func get(byIdentifier id : UUID) -> NoteInformation?
    func update(note: NoteInformation) -> Bool
    func delete(record: NoteInformation) -> Bool
}

struct NoteInformationRepository : NoteRespository {
    
    func create(note: NoteInformation) {
        let cdNote = CDNote(context: PersistenceStorage.shared.context)
        cdNote.noteTitle = note.noteTitle
        cdNote.noteDescription = note.noteDescription
        cdNote.noteImage = note.noteImageData
        cdNote.noteImageUrl = note.noteImage
        cdNote.noteCreationDate = note.noteCreationDate
        PersistenceStorage.shared.saveContext()
    }
    
    func getAll() -> [NoteInformation]? {
        let result = PersistenceStorage.shared.fetchManagedObject(managedObject: CDNote.self)
        var notes : [NoteInformation] = []
        result?.forEach({ cdNote in
            notes.append(cdNote.convertToNote())
        })
        return notes
    }
    
    func get(byIdentifier id: UUID) -> NoteInformation? {
        let result = getNote(byIdentifier: id)
        guard result != nil else {return nil}
        return result?.convertToNote()
    }
    
    func update(note: NoteInformation) -> Bool {
        let cdNote = getNote(byIdentifier: note.id)
        guard cdNote != nil else {return false}
         
        cdNote?.noteTitle = note.noteTitle
        cdNote?.noteDescription = note.noteDescription
        cdNote?.noteImage = note.noteImageData
        PersistenceStorage.shared.saveContext()
        return true
    }
    
    func delete(record: NoteInformation) -> Bool {
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
