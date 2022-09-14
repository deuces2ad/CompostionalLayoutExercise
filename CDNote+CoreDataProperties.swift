//
//  CDNote+CoreDataProperties.swift
//  ComposinalLayoutExercise
//
//  Created by Abhishek Dhiman on 14/09/22.
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
    @NSManaged public var noteTitle: String?
    @NSManaged public var noteImageUrl: String?
    
    func convertToNote() -> NoteInformation {
        return NoteInformation(id: UUID(),
                               noteTitle: self.noteTitle ?? AppConstant.EMPTY_STRING,
                               noteImage: self.noteImageUrl,
                               noteDescription: self.noteDescription ?? AppConstant.EMPTY_STRING,
                               noteCreationDate: noteCreationDate ?? Date(),
                               noteImageData: noteImage)
    }


}

extension CDNote : Identifiable {

}
