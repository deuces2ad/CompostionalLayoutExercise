//
//  CDNote+CoreDataProperties.swift
//  ComposinalLayoutExercise
//
//  Created by Abhishek Dhiman on 13/09/22.
//
//

import Foundation
import CoreData


extension CDNote {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDNote> {
        return NSFetchRequest<CDNote>(entityName: "CDNote")
    }

    @NSManaged public var noteCreationDate: Date?
    @NSManaged public var archived: Bool
    @NSManaged public var noteTitle: String?
    @NSManaged public var noteDescription: String?
    @NSManaged public var noteImage: Data?
    @NSManaged public var id: UUID?
    
    func convertToNote() -> NoteInformation {
        return  NoteInformation(id: self.id ?? UUID(),
                                           noteTitle: self.noteTitle ?? "",
                                           noteImage: self.noteImage,
                                           noteDescription: self.noteDescription ?? "",
                                           noteCreationDate: self.noteCreationDate ?? Date())
    }

}

extension CDNote : Identifiable {

}
