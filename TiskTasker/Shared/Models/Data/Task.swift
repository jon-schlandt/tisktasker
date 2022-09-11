//
//  Task.swift
//  TiskTasker
//
//  Created by Jon Schlandt on 7/14/22.
//

import Foundation

struct Task: Codable {
    var id: UUID?
    var title: String?
    var description: String?
    var points: Int?
    var isCompleted: Bool?
    var enteredDate: String?
    var completionDate: String?
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(id, forKey: .id)
        try container.encode(title, forKey: .title)
        try container.encode(description, forKey: .description)
        try container.encode(points, forKey: .points)
        try container.encode(isCompleted, forKey: .isCompleted)
        try container.encode(enteredDate, forKey: .enteredDate)
        try container.encode(completionDate, forKey: .completionDate)
    }
}

extension Task {
    private enum CodingKeys: String, CodingKey {
        case id
        case title
        case description
        case points
        case isCompleted
        case enteredDate
        case completionDate
    }
}
