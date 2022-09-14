//
//  StatsDataManager.swift
//  TiskTasker
//
//  Created by Jon Schlandt on 7/22/22.
//

import Foundation

class StatsDataManager: DataManager {
    var userStats: UserStats?
    
    func fetchUserStats() async {
        do {
            let params = [ URLQueryItem(name: "userId", value: "0") ]
            userStats = try await fetchItem(at: "http://localhost:3000/user-stats", as: UserStats.self, using: params)
        } catch {
            print("Request failed with error: \(error)")
        }
    }
}
