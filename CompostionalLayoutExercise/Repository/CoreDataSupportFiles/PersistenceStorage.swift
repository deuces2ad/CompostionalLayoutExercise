//
//  PersistenceStorage.swift
//  ComposinalLayoutExercise
//
//  Created by Abhishek Dhiman on 13/09/22.
//

import Foundation
import CoreData

enum StorageType {
    case inMemory
    case persisted
}

final class PersistenceStorage {
    static let shared = PersistenceStorage()
    
    private let coreDateModelFileName = "NotePersistence"
    var persistentContainer: NSPersistentContainer
    
    static var managedObjectModel: NSManagedObjectModel = {
        let bundle = Bundle(for: PersistenceStorage.self)
        guard let url = bundle.url(forResource: "NotePersistence", withExtension: ".momd") else {
            fatalError("Failed to locate momd file")
        }
        guard let model = NSManagedObjectModel(contentsOf: url) else {
            fatalError("Failed to locate momd file")
        }
        return model
    }()
    
    init(storageType: StorageType = .persisted) {
        persistentContainer = NSPersistentContainer(name: coreDateModelFileName, managedObjectModel: Self.managedObjectModel)
        
        if storageType == .inMemory {
            let description = NSPersistentStoreDescription()
            persistentContainer.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
            persistentContainer.persistentStoreDescriptions = [description]
            description.type = NSInMemoryStoreType
        }
        
        persistentContainer.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Core Data failed to load with \(error)")
            }
        }
    }
    
    // MARK: - Core Data Saving support
    @discardableResult
    func saveContext() -> Bool {
        if persistentContainer.viewContext.hasChanges {
            do {
                try persistentContainer.viewContext.save()
                return true
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
        return false
    }
    
    func fetchManagedObject<T:NSManagedObject>(managedObject: T.Type) -> [T]? {
        do {
            guard let result = try
                    PersistenceStorage.shared.persistentContainer.viewContext.fetch(managedObject.fetchRequest()) as? [T] else {return nil}
            return result
        } catch let error{
            print(error.localizedDescription)
        }
        return nil
    }
}
