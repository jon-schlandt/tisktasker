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
        for datum in loadData() {
            let task = Task(
                title: datum.title,
                description: datum.description,
                points: datum.points)
            
            tasks.append(task)
        }
    }
    
    private func loadData() -> [Task] {
        if let path = Bundle.main.path(forResource: "Task", ofType: ".plist"),
           let data = FileManager.default.contents(atPath: path),
           let tasks = try? PropertyListSerialization.propertyList(from: data, format: nil) as? [Task] {
            return tasks
        }
        
        return []
    }
}
