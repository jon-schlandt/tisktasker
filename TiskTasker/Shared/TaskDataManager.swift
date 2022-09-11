//
//  TaskDataManager.swift
//  TiskTasker
//
//  Created by Jon Schlandt on 7/14/22.
//

import Foundation

class TaskDataManager: DataManager {
    var tasks = [Task]()
    
    // MARK: Network Calls
    
    func fetch() async -> Void {
        tasks = [Task]()
        
        do {
            let items = try await fetchItems(at: "http://localhost:3000/tasks", as: [Task].self)
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
        } catch {
            print("Request failed with error: \(error)")
        }
    }
    
    func fetch(for date: Date) async -> Void {
        tasks = [Task]()
        
        do {
            let items = try await fetchItems(at: "http://localhost:3000/tasks", as: [Task].self)
            for item in items {
                guard let _ = item.id,
                      let _ = item.title,
                      let _ = item.points,
                      let isCompleted = item.isCompleted,
                      let _ = item.enteredDate,
                      let completionDate = item.completionDate else {
                          continue
                }
                
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd"
                dateFormatter.locale = Locale(identifier: "en_US")
                
                let taskCompletion = dateFormatter.date(from: completionDate)
                guard let taskCompletion = taskCompletion else {
                    continue
                }
                
                let dateMatches = Calendar.current.isDate(date, equalTo: taskCompletion, toGranularity: .day)
                if dateMatches && isCompleted {
                    tasks.append(item)
                }
            }
        } catch {
            print("Request failed with error: \(error)")
        }
    }
    
    func updateTask(using task: Task) async {
        do {
            let _ = try await updateItem(at: "http://localhost:3000/task", with: task)
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
