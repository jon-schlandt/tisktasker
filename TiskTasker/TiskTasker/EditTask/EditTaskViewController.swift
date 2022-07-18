//
//  EditTaskViewController.swift
//  TiskTasker
//
//  Created by Jon Schlandt on 7/17/22.
//

import UIKit

class EditTaskViewController: UITableViewController {
    @IBOutlet var editTaskTableView: EditTaskTableView!
    var task: Task?

    override func viewDidLoad() {
        super.viewDidLoad()
        mapTaskData()
    }
    
    private func mapTaskData() {
        if let task = task {
            editTaskTableView.taskTitleTextField.text = task.title
            editTaskTableView.taskDescTextView.text = task.description
            mapTaskPoints()
        }
    }
    
    private func mapTaskPoints() {
        switch task?.points {
        case 1:
            editTaskTableView.taskPointsSegControl.selectedSegmentIndex = 0
        case 3:
            editTaskTableView.taskPointsSegControl.selectedSegmentIndex = 1
        case 5:
            editTaskTableView.taskPointsSegControl.selectedSegmentIndex = 2
        case 7:
            editTaskTableView.taskPointsSegControl.selectedSegmentIndex = 3
        case 9:
            editTaskTableView.taskPointsSegControl.selectedSegmentIndex = 4
        default:
            editTaskTableView.taskPointsSegControl.selectedSegmentIndex = 0
        }
    }
}
