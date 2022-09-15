//
//   NewNoteInfo.swift
//  ComposinalLayoutExercise
//
//  Created by Abhishek Dhiman on 11/09/22.
//

import UIKit

struct Note {
    let id : UUID
    let title : String
    let image : URL?
    let description : String
    let creationDate : Date
    let imageData : Data?
}
