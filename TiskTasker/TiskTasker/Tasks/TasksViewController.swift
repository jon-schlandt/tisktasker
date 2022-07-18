//
//  TasksViewController.swift
//  TiskTasker
//
//  Created by Jon Schlandt on 7/14/22.
//

import UIKit

class TasksViewController: UIViewController, UITableViewDataSource {
    @IBOutlet var tableView: UITableView!
    
    private let manager = TaskDataManager()
    private var selectedTask: Task?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showEditTask" {
            if let viewController = segue.destination as? EditTaskViewController,
               let selectedTask = selectedTask {
                viewController.task = selectedTask
            }
        }
    }
    
    private func initialize() {
        manager.fetch()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        manager.getTaskCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath) as! TaskTableViewCell
        let task = manager.getTaskByIndex(at: indexPath.row)
        
        cell.delegate = self
        cell.taskId = task.id
        cell.taskTitleLabel.text = task.title
        cell.taskCompleteButton.setStatusImage(isCompleted: task.isCompleted)
        
        return cell
    }
}

extension TasksViewController: TaskTableViewCellDelegate {
    func editTask(for taskId: Int) {
        selectedTask = manager.getTaskById(for: taskId)
        self.performSegue(withIdentifier: "showEditTask", sender: self)
    }
}
