//
//  TaskDetailsTableView.swift
//  TiskTasker
//
//  Created by Jon Schlandt on 7/21/22.
//

import UIKit

class TaskDetailsView: UIView {
    @IBOutlet var taskPointsLabel: UILabel!
    @IBOutlet var taskTitleLabel: UILabel!
    @IBOutlet var taskDescTextView: UITextView!
    
    func style() {
        taskPointsLabel.font = UIFont(name: "Helvetica Neue", size: 18)
        taskPointsLabel.textColor = UIColor.init(hex: "#929292ff")
        
        taskTitleLabel.font = UIFont(name: "Helvetica Neue Medium", size: 20)
        
        taskDescTextView.backgroundColor = UIColor(red: 0.96, green: 0.96, blue: 0.96, alpha: 1.00)
        taskDescTextView.clipsToBounds = true
        taskDescTextView.layer.cornerRadius = 4
        taskDescTextView.autocapitalizationType = .none
        taskDescTextView.textColor = UIColor.init(hex: "#424242ff")
    }
}
