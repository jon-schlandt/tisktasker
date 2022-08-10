//
//  CompletedTask.swift
//  TiskTasker
//
//  Created by Jon Schlandt on 7/18/22.
//

import Foundation

struct CompletedTask: Decodable {
    var id: Int?
    var title: String?
    var description: String?
    var points: Int?
}

extension CompletedTask {
    private enum CodingKeys: String, CodingKey {
        case id
        case title
        case description
        case points
    }
}
