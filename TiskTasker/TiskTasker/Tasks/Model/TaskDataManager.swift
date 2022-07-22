//
//  TaskDataManager.swift
//  TiskTasker
//
//  Created by Jon Schlandt on 7/14/22.
//

import Foundation

class TaskDataManager {
    var tasks = [Task]()
    
    func fetch() {
        for taskData in loadData() {
            if let _ = taskData["id"],
               let _ = taskData["title"],
               let _ = taskData["description"],
               let _ = taskData["points"],
               let _ = taskData["isCompleted"] {
                tasks.append(Task(taskData: taskData))
            }
        }
    }
    
    func getTaskCount() -> Int {
        tasks.count
    }
    
    func getTaskByIndex(at index: Int) -> Task {
        tasks[index]
    }
    
    func getTaskById(for id: Int) -> Task? {
        self.tasks.first(where: { $0.id == id })
    }
    
    private func loadData() -> [[String: AnyObject]] {
        if let path = Bundle.main.path(forResource: "Tasks", ofType: ".plist"),
           let data = FileManager.default.contents(atPath: path),
           let tasks = try? PropertyListSerialization.propertyList(from: data, format: nil) as? [[String: AnyObject]] {
            return tasks
        }
        
        return []
    }
}
