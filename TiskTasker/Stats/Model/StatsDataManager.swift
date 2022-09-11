//
//  StatsDataManager.swift
//  TiskTasker
//
//  Created by Jon Schlandt on 7/22/22.
//

import Foundation

class StatsDataManager: DataManager {
    var userStats: UserStats?
    
    func fetch() async {
        do {
            userStats = try await fetchItem(at: "http://localhost:3000/user-stats?userid=0", as: UserStats.self)
        } catch {
            print("Request failed with error: \(error)")
        }
    }
}
