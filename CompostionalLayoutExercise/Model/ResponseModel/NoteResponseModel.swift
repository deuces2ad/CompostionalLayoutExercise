//
//  NotesItemsModel.swift
//  CompositionalLayoutExercise
//
//  Created by Abhishek Dhiman on 10/09/22.
//

import Foundation

struct NoteResponseModel: Decodable {
    
    let id: String
    let archived: Bool
    let title, body: String
    let createdTime: Int
    let image: URL?
    let expiryTime: Int?
    
    enum CodingKeys: String, CodingKey {
        case id, archived, title, body
        case createdTime = "created_time"
        case image
        case expiryTime = "expiry_time"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try container.decode(String.self, forKey: .id)
        self.archived = try container.decode(Bool.self, forKey: .archived)
        self.title = try container.decode(String.self, forKey: .title)
        self.body = try container.decode(String.self, forKey: .body)
        self.createdTime = try container.decode(Int.self, forKey: .createdTime)
        if let imageUrl = try? container.decode(String.self, forKey: .image){
            self.image = URL(string: imageUrl)
        }else {
            self.image = nil
        }
        self.expiryTime = try? container.decode(Int.self, forKey: .expiryTime)
    }
    
    init(id: String, archived: Bool, title: String, body: String, createdTime: Int, image: URL?, expiryTime: Int?) {
        self.id = id
        self.archived = archived
        self.title = title
        self.body = body
        self.createdTime = createdTime
        self.image = image
        self.expiryTime = expiryTime
    }
}
