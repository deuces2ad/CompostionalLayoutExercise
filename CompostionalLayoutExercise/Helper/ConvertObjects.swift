//
//  ConvertObjects.swift
//  ComposinalLayoutExercise
//
//  Created by Abhishek Dhiman on 14/09/22.
//

import Foundation


class ConvertObjects {
    
    //MARK: - NoteItemModel --> NoteInformation
    static func convert_NoteItemModel_To_NoteInformation(with item : NoteResponseModel) -> Note {
        let note =  Note(id: UUID(),
                               title: item.title,
                               image: item.image,
                               description: item.body,
                               creationDate: Date(timeIntervalSince1970: TimeInterval(item.createdTime)),
                               imageData: nil)
        return note
    }
    
    //MARK: - NoteInformation  --> NoteItemModel
    static func convert_NoteInformation_To_NoteItemModel(with item : Note) -> NoteResponseModel {
        return NoteResponseModel(id: item.id.uuidString,
                              archived: false,
                              title: item.title,
                              body: item.description,
                              createdTime: Int(Date().timeIntervalSince1970),
                              image: item.image,
                              expiryTime: nil)
    }
    
    static func fetch_all_NoteItemModel(from items : [Note]) -> [NoteResponseModel] {
        return items.map{self.convert_NoteInformation_To_NoteItemModel(with: $0)}
    }
    
    static func fetch_all_NoteInformation(from items : [NoteResponseModel]) -> [Note] {
        return items.map{self.convert_NoteItemModel_To_NoteInformation(with: $0)}
    }
}
