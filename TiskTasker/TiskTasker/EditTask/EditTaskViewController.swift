//
//  EditTaskViewController.swift
//  TiskTasker
//
//  Created by Jon Schlandt on 7/17/22.
//

import UIKit

class EditTaskViewController: UITableViewController {
    var task: Task?
    @IBOutlet var editTaskTableView: EditTaskTableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        mapTaskDataToView()
    }
    
    private func mapTaskDataToView() {
        if let task = task {
            editTaskTableView.taskTitleTextField.text = task.title
            editTaskTableView.taskDescTextView.text = task.description
            mapTaskPointsToView(for: task)
        }
    }
    
    private func mapTaskPointsToView(for task: Task) {
        switch task.points {
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
