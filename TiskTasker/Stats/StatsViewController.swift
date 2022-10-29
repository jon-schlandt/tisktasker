//
//  StatsViewController.swift
//  TiskTasker
//
//  Created by Jon Schlandt on 7/22/22.
//

import UIKit

class StatsViewController: UIViewController {
    let dataManager = StatsDataManager()
    
    @IBOutlet var statsView: StatsView!
    
    override func viewDidLoad() {
        statsView.style()
    }
    
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
        await dataManager.fetchStats()
    }
    
    private func mapStatDataToView() {
        if let stats = dataManager.taskStats {
            if let fullName = stats.fullName {
                statsView.nameLabel.text = fullName
                statsView.initialsLabel.text = getInitials(from: fullName)
            }
            
            if let totalTasks = stats.totalTasks?.description {
                statsView.totalTasks.text = totalTasks
            }
            
            if let totalPoints = stats.totalPoints?.description {
                statsView.totalPoints.text = totalPoints
            }
        }
    }
    
    private func getInitials(from name: String) -> String {
        var initials = ""
        let names = name.components(separatedBy: " ")
        
        for name in names {
            initials += name[name.index(name.startIndex, offsetBy: 0)].uppercased()
        }
        
        return initials
    }
}
