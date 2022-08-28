//
//  Task.swift
//  TiskTasker
//
//  Created by Jon Schlandt on 7/14/22.
//

import Foundation

struct Task: Decodable {
    var id: Int?
    var title: String?
    var description: String?
    var points: Int?
    var isCompleted: Bool?
    var enteredDate: String?
    var completionDate: String?
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
