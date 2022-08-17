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
    
    @IBAction func unwindAddTask(segue: UIStoryboardSegue) {
        guard let source = segue.source as? AddTaskViewController else {
            return
        }
        
        let newTask = Task(
            id: manager.getTaskCount(),
            title: source.addTaskTableView.taskTitleTextField.text,
            description: source.addTaskTableView.taskDescTextView.text,
            points: source.addTaskTableView.getTaskPoints(),
            isCompleted: false
        )
        
        manager.addTask(using: newTask)
        tasksTableView.reloadData()
    }
    
    @IBAction func unwindEditTask(segue: UIStoryboardSegue) {
        guard let source = segue.source as? EditTaskViewController,
              let task = source.task else {
                  return
        }
        
        let updatedTask = Task(
            id: task.id,
            title: source.editTaskTableView.taskTitleTextField.text,
            description: source.editTaskTableView.taskDescTextView.text,
            points: source.editTaskTableView.getTaskPoints(),
            isCompleted: source.task?.isCompleted
        )
            
        manager.updateTask(using: updatedTask)
        tasksTableView.reloadData()
    }
    
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

extension TasksViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        manager.getTaskCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath) as! TasksTableViewCell
        let task = manager.getTaskByIndex(at: indexPath.row)
        
        cell.taskId = task.id
        cell.taskTitleLabel.text = task.title
        cell.taskCompleteButton.setStatusImage(toCompleted: task.isCompleted)
        cell.delegate = self
        
        return cell
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

extension TasksViewController: TaskTableViewCellDelegate {
    func showEditTask(for taskId: Int) {
        selectedTask = manager.getTaskById(for: taskId)
        self.performSegue(withIdentifier: "showEditTask", sender: self)
    }
    
    func toggleTaskComplete(for taskId: Int, using button: TaskStatusUIButton) {
        selectedTask = manager.getTaskById(for: taskId)
        
        guard var selectedTask = selectedTask,
              let _ = selectedTask.isCompleted else {
                  return
        }
        
        selectedTask.isCompleted?.toggle()
        manager.updateTask(using: selectedTask)
        
        tasksTableView.reloadData()
    }
}
