//
//  StatsView.swift
//  TiskTasker
//
//  Created by Jon Schlandt on 7/22/22.
//

import UIKit

class StatsView: UIView {
    @IBOutlet var avatarView: UIImageView!
    @IBOutlet var initialsLabel: UILabel!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var totalTasks: UILabel!
    @IBOutlet var tasksLabel: UILabel!
    @IBOutlet var totalPoints: UILabel!
    @IBOutlet var pointsLabel: UILabel!
    
    func style() {
        avatarView.round()
        avatarView.backgroundColor = UIColor(red: 0.96, green: 0.96, blue: 0.96, alpha: 1.00)
        
        initialsLabel.font = UIFont(name: "Helvetica Neue Light", size: 31)
        nameLabel.font = UIFont(name: "Helvetica Neue Medium", size: 25)
        
        totalTasks.font = UIFont(name: "Helvetica Neue Light", size: 19)
        tasksLabel.font = UIFont(name: "Helvetica Neue Medium", size: 17)
        
        totalPoints.font = UIFont(name: "Helvetica Neue Light", size: 19)
        pointsLabel.font = UIFont(name: "Helvetica Neue Medium", size: 17)
    }
}
