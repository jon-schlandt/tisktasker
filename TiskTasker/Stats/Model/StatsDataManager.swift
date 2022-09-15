//
//  StatsDataManager.swift
//  TiskTasker
//
//  Created by Jon Schlandt on 7/22/22.
//

import Foundation

class StatsDataManager: DataManager {
    var taskStats: TaskStats?
    
    // MARK: Network calls
    
    func fetchStats() async {
        do {
            let params = [ URLQueryItem(name: "userId", value: "0") ]
            taskStats = try await fetchItem(at: "http://localhost:3000/task-stats", as: TaskStats.self, using: params)
        } catch {
            print("Request failed with error: \(error)")
        }
    }
    
    func updateStats(using taskStats: TaskStats) async {
        do {
            let _ = try await updateItem(at: "http://localhost:3000/task-stats", with: taskStats)
        } catch {
            print("Request failed with error: \(error)")
        }
    }
    
    // MARK: Data manipulation
    
    func incrementStats(by points: Int) async {
        await fetchStats()
        
        guard let taskStats = taskStats else {
            return
        }
        
        guard var totalTasks = taskStats.totalTasks,
              var totalPoints = taskStats.totalPoints else {
                  return
        }
        
        totalTasks = totalTasks + 1
        totalPoints = totalPoints + points
        
        let updatedStats = TaskStats(
            userId: taskStats.userId,
            avatarUrl: taskStats.avatarUrl,
            fullName: taskStats.fullName,
            totalTasks: totalTasks,
            totalPoints: totalPoints
        )
        
        await updateStats(using: updatedStats)
    }
}
