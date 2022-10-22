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
        
        editTaskTableView.style()
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
