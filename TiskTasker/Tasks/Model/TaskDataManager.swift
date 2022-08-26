//
//  TaskDataManager.swift
//  TiskTasker
//
//  Created by Jon Schlandt on 7/14/22.
//

import Foundation

class TaskDataManager: DataManager {
    var tasks = [Task]()
    
    // MARK: Data Fetching
    
    func fetch() -> Void {
        getJsonItems(for: "tasks", as: [Task].self) { items in
            for item in items {
                guard let _ = item.id,
                      let _ = item.title,
                      let _ = item.points,
                      let isCompleted = item.isCompleted,
                      let _ = item.enteredDate else {
                          continue
                }
                
                if !isCompleted {
                    tasks.append(item)
                }
            }
        }
    }
    
    // MARK: Gets
    
    func getTaskByIndex(at index: Int) -> Task {
        tasks[index]
    }
    
    func getTaskById(for id: Int?) -> Task? {
        guard let id = id else {
            return nil
        }
        
        return tasks.first(where: { $0.id == id })
    }
    
    func getTaskIndexById(for id: Int?) -> Int? {
        guard let id = id else {
            return nil
        }
        
        return tasks.firstIndex() { task in
            task.id == id
        }
    }
    
    func getTaskCount() -> Int {
        tasks.count
    }
    
    // MARK: Data Manipulation
    
    func addTask(using task: Task) {
        tasks.append(task)
    }
    
    func updateTask(using task: Task) {
        let indexToUpdateAt = getTaskIndexById(for: task.id)
        
        if let indexToUpdateAt = indexToUpdateAt {
            tasks.remove(at: indexToUpdateAt)
            tasks.insert(task, at: indexToUpdateAt)
        }
    }
    
    func deleteTask(at index: Int) {
        tasks.remove(at: index)
    }
}
