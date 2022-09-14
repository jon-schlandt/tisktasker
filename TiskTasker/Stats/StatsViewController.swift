//
//  StatsViewController.swift
//  TiskTasker
//
//  Created by Jon Schlandt on 7/22/22.
//

import UIKit

class StatsViewController: UITableViewController {
    let dataManager = StatsDataManager()
    @IBOutlet var statsTableView: StatsTableView!
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        _Concurrency.Task {
            await initialize()
            mapStatDataToView()
        }
    }
}

// MARK: Private methods

extension StatsViewController {
    private func initialize() async {
        await dataManager.fetchUserStats()
    }
    
    private func mapStatDataToView() {
        if let stats = dataManager.userStats {
            mapInitialsToView(for: stats)
            
            if let fullName = stats.fullName {
                statsTableView.nameLabel.text = fullName
            }
            
            if let totalTasks = stats.totalTasks?.description {
                statsTableView.totalTasksLabel.text = totalTasks
            }
            
            if let totalPoints = stats.totalPoints?.description {
                statsTableView.totalPointsLabel.text = totalPoints
            }
        }
    }
    
    private func mapInitialsToView(for stats: UserStats) {
        var initials = ""
        let names = stats.fullName?.components(separatedBy: " ")
        
        if let names = names {
            for name in names {
                initials += name[name.index(name.startIndex, offsetBy: 0)].uppercased()
            }
        }
        
        statsTableView.initialsLabel.text = initials
    }
}
