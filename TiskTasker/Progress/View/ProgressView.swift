//
//  ProgressView.swift
//  TiskTasker
//
//  Created by Jon Schlandt on 7/22/22.
//

import UIKit

class ProgressView: UIView {
    @IBOutlet var avatarView: UIImageView!
    @IBOutlet var initialsLabel: UILabel!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var taskStatsView: UIView!
    @IBOutlet var statSeparator: UIView!
    @IBOutlet var totalTasks: UILabel!
    @IBOutlet var tasksLabel: UILabel!
    @IBOutlet var totalPoints: UILabel!
    @IBOutlet var pointsLabel: UILabel!
    
    func style() {
        styleUserDetails()
        styleTaskStats()
    }
    
    private func styleUserDetails() {
        avatarView.round()
        avatarView.backgroundColor = UIColor(hex: "#F5F5F5FF")
        
        initialsLabel.font = UIFont.systemFont(ofSize: 29)
        initialsLabel.textColor = UIColor(red: 0.00, green: 0.00, blue: 0.00, alpha: 0.35)
        nameLabel.font = UIFont.systemFont(ofSize: 23, weight: .medium)
    }
    
    private func styleTaskStats() {
        taskStatsView.backgroundColor = .black
        taskStatsView.layer.cornerRadius = 4
        statSeparator.backgroundColor = .white
        
        totalTasks.font = UIFont.systemFont(ofSize: 21)
        totalTasks.textColor = .white
        tasksLabel.font = UIFont.systemFont(ofSize: 13, weight: .medium)
        tasksLabel.textColor = UIColor(red: 1.00, green: 1.00, blue: 1.00, alpha: 0.75)
        
        totalPoints.font = UIFont.systemFont(ofSize: 21)
        totalPoints.textColor = .white
        pointsLabel.font = UIFont.systemFont(ofSize: 13, weight: .medium)
        pointsLabel.textColor = UIColor(red: 1.00, green: 1.00, blue: 1.00, alpha: 0.75)
    }
}
