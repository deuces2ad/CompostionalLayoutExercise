//
//  PersistenceStorage.swift
//  ComposinalLayoutExercise
//
//  Created by Abhishek Dhiman on 17/09/22.
//

import Foundation

extension CDNote {
    
    func toNote() -> Note {
        return Note(id: UUID(),
                    title: self.noteTitle ?? AppConstant.emptyString,
                    image: self.noteImageUrl,
                    description: self.noteDescription ?? AppConstant.emptyString,
                    creationDate: noteCreationDate ?? Date(),
                    imageData: noteImage)
    }
}
