//
//  PersistenceStorage.swift
//  ComposinalLayoutExercise
//
//  Created by Abhishek Dhiman on 13/09/22.
//

import Foundation
import CoreData

final class PersistenceStorage {
    
    private init(){}
    static let shared = PersistenceStorage()
    
    //MARK: - Load Persistence
    lazy var persistenceContainer : NSPersistentContainer =  {
        
        let container = NSPersistentContainer(name: "NotePersistence")
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error as NSError? {
                print("Unable to load persistence container")
            }
        }
        return container
    }()
    
    lazy var context = persistenceContainer.viewContext
    
    //MARK: - Saves changes
    func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let error = error as NSError
                print("Error",error.userInfo)
            }
        }
    }
    
    func fetchManagedObject<T:NSManagedObject>(managedObject: T.Type) -> [T]? {
        do {
            guard let result = try
                    PersistenceStorage.shared.context.fetch(managedObject.fetchRequest()) as? [T] else {return nil}
            return result
        } catch let error{
            print(error.localizedDescription)
        }
        return nil
    }
    
}
