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
    
    func fetchAsync() async -> Void {
        do {
            tasks = try await fetchItemsAsync(for: "http://localhost:3000/tasks", as: [Task].self)
        } catch {
            print("Request failed with error: \(error)")
        }
    }
    
    // MARK: Gets
    
    func getTaskByIndex(at index: Int) -> Task {
        tasks[index]
    }
    
    func getTaskById(for id: UUID?) -> Task? {
        guard let id = id else {
            return nil
        }
        
        return tasks.first(where: { $0.id == id })
    }
    
    func getTaskIndexById(for id: UUID?) -> Int? {
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
