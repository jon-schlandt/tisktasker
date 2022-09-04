//
//  HistoryDataManager.swift
//  TiskTasker
//
//  Created by Jon Schlandt on 7/18/22.
//

import Foundation

class HistoryDataManager: DataManager {
    var tasks = [Task]()
    
    func fetch(for date: Date) {
        getJsonItems(for: "tasks", as: [Task].self) { items in
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
                
                print("here")
                
                let dateMatches = Calendar.current.isDate(date, equalTo: taskCompletion, toGranularity: .day)
                if dateMatches && isCompleted {
                    print(dateMatches)
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
    
    func getTaskById(for id: UUID) -> Task? {
        tasks.first(where: { $0.id == id })
    }
}
