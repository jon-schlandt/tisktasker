//
//  TaskStats.swift
//  TiskTasker
//
//  Created by Jon Schlandt on 7/22/22.
//

import Foundation

struct TaskStats {
    var avatarUrl: String?
    var fullName: String?
    var totalTasks: Int?
    var totalPoints: Int?
}

extension TaskStats {
    init(taskStatData: [String: AnyObject]) {
        self.avatarUrl = taskStatData["avatarUrl"] as? String ?? ""
        self.fullName = taskStatData["fullName"] as? String ?? ""
        self.totalTasks = taskStatData["totalTasks"] as? Int ?? 0
        self.totalPoints = taskStatData["totalPoints"] as? Int ?? 0
    }
}
