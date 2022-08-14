//
//  EditTaskViewController.swift
//  TiskTasker
//
//  Created by Jon Schlandt on 7/17/22.
//

import UIKit

class EditTaskViewController: UITableViewController {
    var task: Task?
    
    var taskTitle: String? { editTaskTableView.taskTitleTextField.text }
    var taskDesc: String { editTaskTableView.taskDescTextView.text }
    var taskPoints: Int {
        switch editTaskTableView.taskPointsSegControl.selectedSegmentIndex {
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
    
    @IBOutlet var editTaskTableView: EditTaskTableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        mapTaskDataToView()
    }
    
    private func mapTaskDataToView() {
        if let task = task {
            editTaskTableView.taskTitleTextField.text = task.title
            editTaskTableView.taskDescTextView.text = task.description
            editTaskTableView.setTaskPoints(points: task.points )
        }
    }
}
