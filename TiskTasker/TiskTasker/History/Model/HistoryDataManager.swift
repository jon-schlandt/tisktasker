//
//  HistoryDataManager.swift
//  TiskTasker
//
//  Created by Jon Schlandt on 7/18/22.
//

import Foundation

class HistoryDataManager: DataManager {
    var completedTasks = [CompletedTask]()
    
    func fetch() {
        loadJsonItems(for: "completedTasks", as: [CompletedTask].self) { items in
            items.forEach() { item in
                if let _ = item.id,
                   let _ = item.title,
                   let _ = item.points {
                    completedTasks.append(item)
                }
            }
        }
    }
    
    func getTaskCount() -> Int {
        completedTasks.count
    }
    
    func getTaskByIndex(at index: Int) -> CompletedTask {
        completedTasks[index]
    }
    
    func getTaskById(for id: Int) -> CompletedTask? {
        completedTasks.first(where: { $0.id == id })
    }
}
