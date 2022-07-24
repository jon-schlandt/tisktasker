//
//  StatsDataManager.swift
//  TiskTasker
//
//  Created by Jon Schlandt on 7/22/22.
//

import Foundation

class StatsDataManager: DataManager {
    var taskStats: TaskStats?
    
    func fetch() {
        let taskStatData = loadPlistItem(for: "TaskStats")
        
        if let _ = taskStatData["fullName"],
           let _ = taskStatData["totalTasks"],
           let _ = taskStatData["totalPoints"] {
            taskStats = TaskStats(taskStatData: taskStatData)
        }
    }
}
