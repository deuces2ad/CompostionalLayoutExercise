//
//  AppConstants.swift
//  ComposinalLayoutExercise
//
//  Created by Abhishek Dhiman on 13/09/22.
//

import Foundation

struct AppConstant {
    static let emptyString            = String()
    static let appDateFormat          = "MMM dd, yyyy"
    static let isNotesSynced          = "isNotesSynced"
}

struct ValidationConstant {
    static let emptyTitle             = "Note Title cannot be left empty."
    static let emptyDescription       = "Note Description cannot be left empty."
}

struct ServiceEndPoint {
    static let getNotes               = URL(string:"https://raw.githubusercontent.com/RishabhRaghunath/JustATest/master/notes")
}

struct ServiceError {
    static let invalidURL       = "InValid Url"
    static let decodeFailure    = "Failed to decode json response"
}

struct UIConstant {
    static let alertTitle             = "Daily Note"
    static let noInternetAlertMessage = "No internet connectivity,please check your internet connection."
    static let noInternet             = "No network connection"
    static let navigationTitle        = "Notes"
    static let firstColorIndex        = 0
}
