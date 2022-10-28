//
//  TaskDetailsViewController.swift
//  TiskTasker
//
//  Created by Jon Schlandt on 7/21/22.
//

import UIKit

class TaskDetailsViewController: UIViewController {
    var selectedTask: Task?
    
    @IBOutlet var taskDetailsView: TaskDetailsView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapTaskDataToView()
        taskDetailsView.style()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func mapTaskDataToView() {
        if let selectedTask = selectedTask {
            taskDetailsView.taskTitleLabel.text = selectedTask.title
            taskDetailsView.taskDescTextView.text = selectedTask.description
            mapTaskPointsToView(for: selectedTask)
        }
    }
    
    private func mapTaskPointsToView(for task: Task) {
        guard let points = task.points else {
            return
        }
        
        var pointsLabel = "\(points) point"
        
        if points > 1 {
            pointsLabel += "s"
        }
        
        taskDetailsView.taskPointsLabel.text = pointsLabel
    }
}
