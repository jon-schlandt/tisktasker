//
//  TaskDetailsViewController.swift
//  TiskTasker
//
//  Created by Jon Schlandt on 7/21/22.
//

import UIKit

class TaskDetailsViewController: UITableViewController {
    @IBOutlet var taskDetailsTableView: TaskDetailsTableView!
    var selectedTask: CompletedTask?

    override func viewDidLoad() {
        super.viewDidLoad()
        mapTaskData()
    }
    
    private func mapTaskData() {
        if let selectedTask = selectedTask {
            taskDetailsTableView.taskTitleLabel.text = selectedTask.title
            taskDetailsTableView.taskDescTextView.text = selectedTask.description
            mapTaskPoints(task: selectedTask)
        }
    }
    
    private func mapTaskPoints(task: CompletedTask) {
        guard let points = task.points else {
            return
        }
        
        var pointsLabel = "\(points) point"
        
        if points > 1 {
            pointsLabel += "s"
        }
        
        taskDetailsTableView.taskPointsLabel.text = pointsLabel
    }
}
