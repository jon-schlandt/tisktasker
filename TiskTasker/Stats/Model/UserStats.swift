//
//  UserStats.swift
//  TiskTasker
//
//  Created by Jon Schlandt on 7/22/22.
//

import Foundation

struct UserStats: Decodable {
    var avatarUrl: String?
    var fullName: String?
    var totalTasks: Int?
    var totalPoints: Int?
}

extension UserStats {
    private enum CodingKeys: String, CodingKey {
        case avatarUrl
        case fullName
        case totalTasks
        case totalPoints
    }
}
