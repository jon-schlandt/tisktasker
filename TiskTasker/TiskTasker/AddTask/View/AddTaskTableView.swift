//
//  AddTaskTableView.swift
//  TiskTasker
//
//  Created by Jon Schlandt on 8/14/22.
//

import UIKit

class AddTaskTableView: UITableView {
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
}
