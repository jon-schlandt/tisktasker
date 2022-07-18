//
//  Task.swift
//  TiskTasker
//
//  Created by Jon Schlandt on 7/14/22.
//

import Foundation

struct Task {
    var id: Int?
    var title: String?
    var description: String?
    var points: Int?
    var isCompleted: Bool
}

extension Task {
    init(taskData: [String: AnyObject]) {
        self.id = taskData["id"] as? Int ?? 0
        self.title = taskData["title"] as? String ?? ""
        self.description = taskData["description"] as? String ?? ""
        self.points = taskData["points"] as? Int ?? 1
        self.isCompleted = taskData["isCompleted"] as? Bool ?? false
    }
}
