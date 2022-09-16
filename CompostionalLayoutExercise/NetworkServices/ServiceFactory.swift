//
//  ServiceFactory.swift
//  CompostionalLayoutExercise
//
//  Created by Abhishek Dhiman on 15/09/22.
//

import Foundation

class ServiceFactory {
    func createNoteService() -> NoteServiceProtocol {
        return NoteService()
    }
}
