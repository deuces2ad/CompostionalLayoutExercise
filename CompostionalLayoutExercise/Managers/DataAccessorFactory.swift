//
//  DataAccessorFactory.swift
//  CompostionalLayoutExercise
//
//  Created by Abhishek Dhiman on 15/09/22.
//

import Foundation

class DataAccessorFactory {
    func createNoteDataAccessor() -> NoteDataAccessorProtocol {
        return NoteDataAccessor()
    }
}
