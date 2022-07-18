//
//  CompletedTask.swift
//  TiskTasker
//
//  Created by Jon Schlandt on 7/18/22.
//

import Foundation

struct CompletedTask {
    var id: Int?
    var title: String?
    var description: String?
    var points: Int?
}

extension CompletedTask {
    init(taskData: [String: AnyObject]) {
        self.id = taskData["id"] as? Int ?? 0
        self.title = taskData["title"] as? String ?? ""
        self.description = taskData["description"] as? String ?? ""
        self.points = taskData["points"] as? Int ?? 1
    }
}
