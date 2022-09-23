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
    
    func fetchTasks() async -> Void {
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
    
    func fetchTasks(for date: Date) async -> Void {
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
                
                let taskCompletion = DateUtil().convertToDate(from: completionDate)
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
    
    func addTask(using task: Task) async {
        do {
            let _ = try await addItem(at: "http://localhost:3000/task", with: task)
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
    
    func deleteTask(using taskId: UUID) async {
        do {
            let params = [ URLQueryItem(name: "taskId", value: taskId.description) ]
            let _ = try await deleteItem(at: "http://localhost:3000/task", using: params)
        } catch {
            print("Request failed with error: \(error)")
        }
    }
    
    // MARK: Local GETs
    
    func getTaskByIndex(at index: Int) -> Task {
        tasks[index]
    }
    
    func getTaskById(for id: UUID) -> Task? {
        return tasks.first(where: { $0.id == id })
    }
    
    func getTaskCount() -> Int {
        tasks.count
    }
}
