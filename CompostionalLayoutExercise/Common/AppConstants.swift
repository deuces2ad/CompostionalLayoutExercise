//
//  AppConstants.swift
//  ComposinalLayoutExercise
//
//  Created by Abhishek Dhiman on 13/09/22.
//

import Foundation

//
struct AppConstant {
    static let EMPTY_STRING = ""
    static let appDateFormat = "MMM dd, yyyy"
    static let isNotesFetchedAlreadyFromAPI = "isNotesFetchedAlreadyFromAPI"
}

struct ServiceEndPoint {
    static let getNotes = URL(string:"https://raw.githubusercontent.com/RishabhRaghunath/JustATest/master/notes")
}

struct UIConstant {
    static let alertTitle = "Daily Note"
    static let noInternetAlertMessage = "No internet connectivity,please check your internet connection."
    static let noInternet = "No network connection"
    static let navigationTitle = "Notes"
    static let firstColorIndex = 0
}

