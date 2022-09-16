//
//  NoteRepositoryFactory.swift
//  CompostionalLayoutExercise
//
//  Created by Abhishek Dhiman on 15/09/22.
//

import Foundation

class NoteRepositoryFactory {
    func createNoteRepository() -> NoteRepository {
        return NoteDataRepository()
    }
}
