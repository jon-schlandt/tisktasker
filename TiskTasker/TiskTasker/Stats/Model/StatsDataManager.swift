//
//  StatsDataManager.swift
//  TiskTasker
//
//  Created by Jon Schlandt on 7/22/22.
//

import Foundation

class StatsDataManager {
    var taskStats: TaskStats?
    
    func fetch() {
        let taskStatData = loadData()
        
        if let _ = taskStatData["fullName"],
           let _ = taskStatData["totalTasks"],
           let _ = taskStatData["totalPoints"] {
            taskStats = TaskStats(taskStatData: taskStatData)
        }
    }
    
    private func loadData() -> [String: AnyObject] {
        if let path = Bundle.main.path(forResource: "TaskStats", ofType: ".plist"),
           let data = FileManager.default.contents(atPath: path),
           let stats = try? PropertyListSerialization.propertyList(from: data, format: nil) as? [String: AnyObject] {
            return stats
        }
        
        return [:]
    }
}
