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
        addTableRow(at: manager.getTaskCount() - 1)
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
        
        if let taskIndex = manager.getTaskIndexById(for: updatedTask.id) {
            manager.updateTask(using: updatedTask)
            updateTableRow(at: taskIndex)
        }
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
}

// MARK: UITableViewDataSource methods

extension TasksViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if manager.tasks.isEmpty {
            showEmptyMsg()
            return 0
        }
        
        tasksTableView.backgroundView = nil
        return manager.getTaskCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath) as! TasksTableViewCell
        let task = manager.getTaskByIndex(at: indexPath.row)
        
        cell.taskId = task.id
        cell.taskTitleLabel.text = task.title
        cell.taskCompleteButton.setStatusImage(to: task.isCompleted)
        cell.delegate = self
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            manager.deleteTask(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            
            if manager.tasks.isEmpty {
                tasksTableView.reloadData()
            }
        }
    }
}

// MARK: UITableViewDelegate methods

extension TasksViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
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

// MARK: TaskTableViewCellDelegate methods

extension TasksViewController: TaskTableViewCellDelegate {
    func showEditTask(for taskId: Int?) {
        selectedTask = manager.getTaskById(for: taskId)
        
        if let _ = selectedTask {
            self.performSegue(withIdentifier: "showEditTask", sender: self)
        }
    }
    
    func toggleTaskComplete(for taskId: Int?, using button: TaskStatusUIButton) {
        let taskToToggle = manager.getTaskById(for: taskId)
        
        guard var taskToToggle = taskToToggle,
              let taskIndex = manager.getTaskIndexById(for: taskToToggle.id) else {
            return
        }
        
        taskToToggle.isCompleted?.toggle()
        
        manager.updateTask(using: taskToToggle)
        updateTableRow(at: taskIndex)
    }
}


// MARK: Private methods

extension TasksViewController {
    private func initialize() {
        tasksTableView.register(TableViewHeader.self, forHeaderFooterViewReuseIdentifier: TableViewHeader.reuseIdentifier)
        manager.fetch()
    }
    
    private func showEmptyMsg() {
        let emptyMsg = UILabel(frame: CGRect(x: 0, y: 0, width: tasksTableView.frame.width, height: tasksTableView.frame.height))
        emptyMsg.textAlignment = .center
        emptyMsg.text = "No tasks for today."

        tasksTableView.backgroundView = emptyMsg
        tasksTableView.separatorStyle = .none
    }
    
    private func addTableRow(at index: Int) {
        tasksTableView.beginUpdates()
        tasksTableView.insertRows(at: [IndexPath.init(row: index, section: 0)], with: .automatic)
        tasksTableView.endUpdates()
    }
    
    private func updateTableRow(at index: Int) {
        tasksTableView.beginUpdates()
        tasksTableView.reloadRows(at: [IndexPath.init(row: index, section: 0)], with: .automatic)
        tasksTableView.endUpdates()
    }
}