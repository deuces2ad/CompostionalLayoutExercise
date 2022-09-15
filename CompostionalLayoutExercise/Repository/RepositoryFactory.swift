//
//  RepositoryFactory.swift
//  CompostionalLayoutExercise
//
//  Created by Abhishek Dhiman on 15/09/22.
//

import Foundation

class RepositoryFactory {
    static func createNoteDataRepository() -> NoteRepository {
        return NoteDataRepository()
    }
}
