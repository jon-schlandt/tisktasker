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
                      let enteredDate = item.enteredDate else {
                          continue
                }
                
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd"
                dateFormatter.locale = Locale(identifier: "en_US")
                
                let taskDate = dateFormatter.date(from: enteredDate)
                guard let taskDate = taskDate else {
                    continue
                }
                
                let dateMatches = Calendar.current.isDate(date, equalTo: taskDate, toGranularity: .day)
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
    
    func getTaskById(for id: Int) -> Task? {
        tasks.first(where: { $0.id == id })
    }
}
