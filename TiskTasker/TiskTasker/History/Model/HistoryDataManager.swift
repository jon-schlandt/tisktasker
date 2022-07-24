//
//  HistoryDataManager.swift
//  TiskTasker
//
//  Created by Jon Schlandt on 7/18/22.
//

import Foundation

class HistoryDataManager: DataManager {
    var completedTasks = [CompletedTask]()
    
    func fetch() {
        for taskData in loadPlistItems(for: "CompletedTasks") {
            if let _ = taskData["id"],
               let _ = taskData["title"],
               let _ = taskData["description"],
               let _ = taskData["points"] {
                completedTasks.append(CompletedTask(taskData: taskData))
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
}
