//
//  Progress.swift
//  TiskTasker
//
//  Created by Jon Schlandt on 7/22/22.
//

import Foundation

struct Progress: Codable {
    var userId: Int?
    var avatarUrl: String?
    var fullName: String?
    var totalTasks: Int?
    var totalPoints: Int?
}

extension Progress {
    private enum CodingKeys: String, CodingKey {
        case userId
        case avatarUrl
        case fullName
        case totalTasks
        case totalPoints
    }
}
