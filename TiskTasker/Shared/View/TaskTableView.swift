//
//  TaskTableView.swift
//  TiskTasker
//
//  Created by Jon Schlandt on 10/15/22.
//

import UIKit

class TaskTableView: UITableView {
    var taskTitleTextField: UITextField!
    var taskDescTextView: UITextView!
    var taskPointsSegControl: UISegmentedControl!
    
    func style() {
        taskTitleTextField.backgroundColor = UIColor(red: 0.96, green: 0.96, blue: 0.96, alpha: 1.00)
        taskTitleTextField.clipsToBounds = true
        taskTitleTextField.layer.cornerRadius = 4
        
        taskDescTextView.backgroundColor = UIColor(red: 0.96, green: 0.96, blue: 0.96, alpha: 1.00)
        taskDescTextView.clipsToBounds = true
        taskDescTextView.layer.cornerRadius = 4
        taskDescTextView.textContainerInset.left = 4
        taskDescTextView.autocapitalizationType = .none
        
        fixBackgroundSegmentControl(taskPointsSegControl)
        taskPointsSegControl.backgroundColor = UIColor(red: 0.96, green: 0.96, blue: 0.96, alpha: 1.00)
        taskPointsSegControl.selectedSegmentTintColor = .black
        taskPointsSegControl.setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "Helvetica Neue", size: 15)!], for: .normal)
        taskPointsSegControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont(name: "Helvetica Neue Medium", size: 15)!], for: .selected)
    }
    
    func fixBackgroundSegmentControl( _ segmentControl: UISegmentedControl){
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            for i in 0...(segmentControl.numberOfSegments - 1) {
                let backgroundSegmentView = segmentControl.subviews[i]
                backgroundSegmentView.isHidden = true
            }
        }
    }
    
    func getTaskPoints() -> Int {
        switch taskPointsSegControl.selectedSegmentIndex {
        case 1:
            return 3
        case 2:
            return 5
        case 3:
            return 7
        case 4:
            return 9
        default:
            return 1
        }
    }

}
