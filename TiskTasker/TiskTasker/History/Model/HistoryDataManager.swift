//
//  HistoryDataManager.swift
//  TiskTasker
//
//  Created by Jon Schlandt on 7/18/22.
//

import Foundation

class HistoryDataManager {
    var completedTasks = [CompletedTask]()
    
    func fetch() {
        for task in loadData() {
            if let _ = task["id"],
               let _ = task["title"],
               let _ = task["description"],
               let _ = task["points"] {
                completedTasks.append(CompletedTask(taskData: task))
            }
        }
    }
    
    func getTaskCount() -> Int {
        completedTasks.count
    }
    
    func getTaskByIndex(at index: Int) -> CompletedTask {
        completedTasks[index]
    }
    
    func getTaskById(for id: Int) -> CompletedTask? {
        completedTasks.first(where: { $0.id == id })
    }
    
    private func loadData() -> [[String: AnyObject]] {
        if let path = Bundle.main.path(forResource: "CompletedTasks", ofType: ".plist"),
           let data = FileManager.default.contents(atPath: path),
           let completedTasks = try? PropertyListSerialization.propertyList(from: data, format: nil) as? [[String: AnyObject]] {
                return completedTasks
        }
        
        return [[:]]
    }
}
