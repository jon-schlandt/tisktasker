//
//  StatsViewController.swift
//  TiskTasker
//
//  Created by Jon Schlandt on 7/22/22.
//

import UIKit

class StatsViewController: UITableViewController {
    let manager = StatsDataManager()
    @IBOutlet var statsTableView: StatsTableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        manager.fetch()
        mapStatDataToView()
    }
    
    private func initialize() {
        manager.fetch()
    }
    
    private func mapStatDataToView() {
        if let stats = manager.taskStats {
            mapInitialsToView(for: stats)
            statsTableView.nameLabel.text = stats.fullName
            statsTableView.totalTasksLabel.text = stats.totalTasks?.description
            statsTableView.totalPointsLabel.text = stats.totalPoints?.description
        }
    }
    
    private func mapInitialsToView(for stats: TaskStats) {
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
