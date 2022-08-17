//
//  EditTaskTableView.swift
//  TiskTasker
//
//  Created by Jon Schlandt on 7/17/22.
//

import UIKit

class EditTaskTableView: UITableView {
    @IBOutlet var taskTitleTextField: UITextField!
    @IBOutlet var taskDescTextView: UITextView!
    @IBOutlet var taskPointsSegControl: UISegmentedControl!
    
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
    
    func setTaskPoints(points: Int?) {
        switch points {
        case 3:
            taskPointsSegControl.selectedSegmentIndex = 1
        case 5:
            taskPointsSegControl.selectedSegmentIndex = 2
        case 7:
            taskPointsSegControl.selectedSegmentIndex = 3
        case 9:
            taskPointsSegControl.selectedSegmentIndex = 4
        default:
            taskPointsSegControl.selectedSegmentIndex = 0
        }
    }
}
