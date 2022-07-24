//
//  TasksViewController.swift
//  TiskTasker
//
//  Created by Jon Schlandt on 7/14/22.
//

import UIKit

class TasksViewController: UIViewController {
    private let manager = TaskDataManager()
    private var selectedTask: Task?
    
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showEditTask" {
            if let destination = segue.destination as? EditTaskViewController,
               let selectedTask = selectedTask {
                destination.task = selectedTask
            }
        }
    }
    
    private func initialize() {
        manager.fetch()
    }
}

extension TasksViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        manager.getTaskCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath) as! TasksTableViewCell
        let task = manager.getTaskByIndex(at: indexPath.row)
        
        cell.delegate = self
        cell.taskId = task.id
        cell.taskTitleLabel.text = task.title
        cell.taskCompleteButton.setStatusImage(toCompleted: task.isCompleted)
        
        return cell
    }
}

extension TasksViewController: TaskTableViewCellDelegate {
    func editTask(for taskId: Int) {
        selectedTask = manager.getTaskById(for: taskId)
        self.performSegue(withIdentifier: "showEditTask", sender: self)
    }
}
