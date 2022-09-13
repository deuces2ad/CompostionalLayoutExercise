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
}

struct ServiceEndPoint {
    static let getNotes = URL(string:"https://raw.githubusercontent.com/RishabhRaghunath/JustATest/master/notes")
}

struct UIConstant {
    static let alertTitle = "Daily Note"
}
