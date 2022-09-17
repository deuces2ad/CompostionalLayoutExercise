//
//  NoteViewModelFactory.swift
//  CompostionalLayoutExercise
//
//  Created by Abhishek Dhiman on 17/09/22.
//

import Foundation

class NoteViewModelFactory {
    static func createNoteViewModelFactory() -> NoteViewModelProtocol {
        return NoteViewModel()
    }
}
