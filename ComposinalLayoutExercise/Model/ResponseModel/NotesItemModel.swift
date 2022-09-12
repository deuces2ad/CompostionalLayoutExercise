//
//  NotesItemsModel.swift
//  ComposinalLayoutExercise
//
//  Created by Abhishek Dhiman on 10/09/22.
//

import Foundation

struct NotesItemModel :Decodable {
    let id: String
    let archived: Bool
    let title, body: String
    let createdTime: Int
    let image: String?
    let expiryTime: Int?

    enum CodingKeys: String, CodingKey {
        case id, archived, title, body
        case createdTime = "created_time"
        case image
        case expiryTime = "expiry_time"
    }
}
