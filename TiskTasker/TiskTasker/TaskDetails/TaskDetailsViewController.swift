//
//  TaskDetailsViewController.swift
//  TiskTasker
//
//  Created by Jon Schlandt on 7/21/22.
//

import UIKit

class TaskDetailsViewController: UITableViewController {
    var selectedTask: CompletedTask?
    @IBOutlet var taskDetailsTableView: TaskDetailsTableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        mapTaskDataToView()
    }
    
    private func mapTaskDataToView() {
        if let selectedTask = selectedTask {
            taskDetailsTableView.taskTitleLabel.text = selectedTask.title
            taskDetailsTableView.taskDescTextView.text = selectedTask.description
            mapTaskPointsToView(for: selectedTask)
        }
    }
    
    private func mapTaskPointsToView(for task: CompletedTask) {
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
