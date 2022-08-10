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
    
    @IBOutlet var tasksTableView: UITableView!
    
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
        self.tasksTableView.register(TableViewHeader.self, forHeaderFooterViewReuseIdentifier: TableViewHeader.reuseIdentifier)
        manager.fetch()
    }
}

extension TasksViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        tableView.sectionHeaderTopPadding = 0
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeZone = .none
        dateFormatter.locale = Locale(identifier: "en_US")
        
        guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: TableViewHeader.reuseIdentifier) as? TableViewHeader else {
            return nil
        }
        
        headerView.label.text = dateFormatter.string(from: Date())
        return headerView
    }
}

extension TasksViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        manager.getTaskCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath) as! TasksTableViewCell
        let task = manager.getTaskByIndex(at: indexPath.row)
        
        if let id = task.id { cell.taskId = id }
        if let title = task.title { cell.taskTitleLabel.text = title }
        if let isCompleted = task.isCompleted { cell.taskCompleteButton.setStatusImage(toCompleted: isCompleted) }
        
        cell.delegate = self
        return cell
    }
}

extension TasksViewController: TaskTableViewCellDelegate {
    func editTask(for taskId: Int) {
        selectedTask = manager.getTaskById(for: taskId)
        self.performSegue(withIdentifier: "showEditTask", sender: self)
    }
}
