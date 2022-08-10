//
//  TaskDataManager.swift
//  TiskTasker
//
//  Created by Jon Schlandt on 7/14/22.
//

import Foundation

class TaskDataManager: DataManager {
    var tasks = [Task]()
    
    func fetch() {
        loadJsonItems(for: "tasks", as: [Task].self) { items in
            items.forEach() { item in
                if let _ = item.id,
                   let _ = item.title,
                   let _ = item.points,
                   let _ = item.isCompleted {
                    tasks.append(item)
                }
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
}
