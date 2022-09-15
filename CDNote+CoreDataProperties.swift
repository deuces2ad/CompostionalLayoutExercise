//
//  CDNote+CoreDataProperties.swift
//  ComposinalLayoutExercise
//
//  Created by Abhishek Dhiman on 15/09/22.
//
//

import Foundation
import CoreData


extension CDNote {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDNote> {
        return NSFetchRequest<CDNote>(entityName: "CDNote")
    }

    @NSManaged public var archived: Bool
    @NSManaged public var id: UUID?
    @NSManaged public var noteCreationDate: Date?
    @NSManaged public var noteDescription: String?
    @NSManaged public var noteImage: Data?
    @NSManaged public var noteImageUrl: URL?
    @NSManaged public var noteTitle: String?
    
    func convertToNote() -> Note {
        return Note(id: UUID(),
                               title: self.noteTitle ?? AppConstant.EMPTY_STRING,
                               image: self.noteImageUrl,
                               description: self.noteDescription ?? AppConstant.EMPTY_STRING,
                               creationDate: noteCreationDate ?? Date(),
                               imageData: noteImage)
    }

}

extension CDNote : Identifiable {

}
