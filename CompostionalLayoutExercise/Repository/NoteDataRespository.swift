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
    func getNotes() -> [Note]?
    func get(byIdentifier id : UUID) -> Note?
}

class NoteDataRepository: NoteRepository {
    
    func save(note: Note) -> Bool {
        createNoteManagedObjectInStorage(note: note)
        return PersistenceStorage.shared.saveContext()
    }
    
    func saveNotes(notes: Array<Note>) -> Bool {
        for noteToAdd in notes {
            createNoteManagedObjectInStorage(note: noteToAdd)
        }
        return PersistenceStorage.shared.saveContext()
    }
    
    func getNotes() -> Array<Note>? {
        let result = PersistenceStorage.shared.fetchManagedObject(managedObject: CDNote.self)
        var notes : [Note] = []
        result?.forEach({ cdNote in
            notes.append(cdNote.toNote())
        })
        return notes
    }
    
    func get(byIdentifier id: UUID) -> Note? {
        let result = getNote(byIdentifier: id)
        guard result != nil else {return nil}
        return result?.toNote()
    }
    
    // MARK: Private Method
    func createNoteManagedObjectInStorage(note: Note) {
        let cdNote = CDNote(context: PersistenceStorage.shared.persistentContainer.viewContext)
        cdNote.id = note.id
        cdNote.noteTitle = note.title
        cdNote.noteDescription = note.description
        cdNote.noteImage = note.imageData
        cdNote.noteImageUrl = note.image
        cdNote.noteCreationDate = note.creationDate
    }
    
    private func getNote(byIdentifier id : UUID)-> CDNote? {
        let fetchRequest  = NSFetchRequest<CDNote>(entityName: "CDNote")
        let sortDescriptor  = NSSortDescriptor(key: "noteCreationDate", ascending: false)
        fetchRequest.sortDescriptors = [sortDescriptor]
        let predicate = NSPredicate(format: "@id==%@", id as CVarArg)
        fetchRequest.predicate = predicate
        do {
            let result = try PersistenceStorage.shared.persistentContainer.viewContext.fetch(fetchRequest).first
            guard result != nil else  {return nil}
            return result
        } catch let error {
            print("ERROR",error)
        }
        return nil
    }
}
