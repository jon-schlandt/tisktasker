//
//  StatsViewController.swift
//  TiskTasker
//
//  Created by Jon Schlandt on 7/22/22.
//

import UIKit

class StatsViewController: UITableViewController {
    @IBOutlet var statsTableView: StatsTableView!
    let manager = StatsDataManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        manager.fetch()
        mapStatsToView()
    }
    
    private func initialize() {
        manager.fetch()
    }
    
    private func mapStatsToView() {
        if let stats = manager.taskStats {
            mapInitialsToView(stats: stats)
            statsTableView.nameLabel.text = stats.fullName
            statsTableView.totalTasksLabel.text = stats.totalTasks?.description
            statsTableView.totalPointsLabel.text = stats.totalPoints?.description
        }
    }
    
    private func mapInitialsToView(stats: TaskStats) {
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
