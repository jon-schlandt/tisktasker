//
//  StatsDataManager.swift
//  TiskTasker
//
//  Created by Jon Schlandt on 7/22/22.
//

import Foundation

class StatsDataManager: DataManager {
    var userStats: UserStats?
    
    func fetch() {
        loadJsonItem(for: "userStats", as: UserStats.self) { item in
            userStats = item
        }
    }
}
