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
        for task in loadData() {
            if let _ = task["id"],
               let _ = task["title"],
               let _ = task["description"],
               let _ = task["points"],
               let _ = task["isCompleted"] {
                tasks.append(Task(taskData: task))
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
