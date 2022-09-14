//
//   NewNoteInfo.swift
//  ComposinalLayoutExercise
//
//  Created by Abhishek Dhiman on 11/09/22.
//

import UIKit

struct  NoteInformation {
    let id : UUID
    let noteTitle : String
    let noteImage : String?
    let noteDescription : String
    let noteCreationDate : Date
    let noteImageData : Data?
}
