//
//  NoteResponseModelExtensions.swift
//  CompostionalLayoutExercise
//
//  Created by Abhishek Dhiman on 15/09/22.
//

import Foundation

extension NoteResponseModel {
    
    func toNote() -> Note {
        return Note(id: UUID(),
                    title: self.title,
                    image: self.image,
                    description: self.body,
                    creationDate: Date(timeIntervalSince1970: TimeInterval(self.createdTime)),
                    imageData: nil)
    }
}

extension Array where Element == NoteResponseModel {
    func toNotes() -> Array<Note> {
        return self.map{ $0.toNote() }
    }
}
