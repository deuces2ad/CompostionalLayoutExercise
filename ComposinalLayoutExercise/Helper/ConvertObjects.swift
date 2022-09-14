//
//  ConvertObjects.swift
//  ComposinalLayoutExercise
//
//  Created by Abhishek Dhiman on 14/09/22.
//

import Foundation


class ConvertObjects {
    
    //MARK: - NoteItemModel --> NoteInformation
    static func convert_NoteItemModel_To_NoteInformation(with item : NotesItemModel) -> NoteInformation {
        let note =  NoteInformation(id: UUID(),
                               noteTitle: item.title,
                               noteImage: item.image,
                               noteDescription: item.body,
                               noteCreationDate: Date(timeIntervalSince1970: TimeInterval(item.createdTime)),
                               noteImageData: nil)
        return note
    }
    
    //MARK: - NoteInformation  --> NoteItemModel
    static func convert_NoteInformation_To_NoteItemModel(with item : NoteInformation) -> NotesItemModel {
        return NotesItemModel(id: item.id.uuidString,
                              archived: false,
                              title: item.noteTitle,
                              body: item.noteDescription,
                              createdTime: Int(Date().timeIntervalSince1970),
                              image: item.noteImage,
                              expiryTime: nil)
    }
    
    static func fetch_all_NoteItemModel(from items : [NoteInformation]) -> [NotesItemModel] {
        return items.map{self.convert_NoteInformation_To_NoteItemModel(with: $0)}
    }
    
    static func fetch_all_NoteInformation(from items : [NotesItemModel]) -> [NoteInformation] {
        return items.map{self.convert_NoteItemModel_To_NoteInformation(with: $0)}
    }
}
