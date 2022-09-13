//
//  TasksViewController.swift
//  TiskTasker
//
//  Created by Jon Schlandt on 7/14/22.
//

import UIKit

class TasksViewController: UIViewController {
    private let dataManager = TaskDataManager()
    private var selectedTask: Task?
    private var isInitializing = false
    
    @IBOutlet var tasksTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tasksTableView.separatorStyle = .none
        
        _Concurrency.Task {
            await initialize()
            tasksTableView.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showEditTask" {
            if let destination = segue.destination as? EditTaskViewController,
               let selectedTask = selectedTask {
                destination.task = selectedTask
            }
        }
    }
    
    @IBAction func unwindAddTask(segue: UIStoryboardSegue) {
        guard let source = segue.source as? AddTaskViewController else {
            return
        }
        
        let newTask = Task(
            title: source.addTaskTableView.taskTitleTextField.text,
            description: source.addTaskTableView.taskDescTextView.text,
            points: source.addTaskTableView.getTaskPoints()
        )
        
        _Concurrency.Task {
            await dataManager.addTask(using: newTask)
            await dataManager.fetchTasks()
            
            tasksTableView.reloadData()
        }
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
            isCompleted: task.isCompleted,
            enteredDate: task.enteredDate,
            completionDate: task.completionDate
        )
        
        _Concurrency.Task {
            await dataManager.updateTask(using: updatedTask)
            await dataManager.fetchTasks()
            
            tasksTableView.reloadData()
        }
    }
}

// MARK: UITableViewDataSource methods

extension TasksViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !dataManager.tasks.isEmpty {
            tasksTableView.backgroundView = nil
            return dataManager.getTaskCount()
        }
        
        if !isInitializing { showEmptyMsg() }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath) as! TasksTableViewCell
        let task = dataManager.getTaskByIndex(at: indexPath.row)
        
        cell.taskId = task.id
        cell.taskTitleLabel.text = task.title
        cell.taskCompleteButton.isChecked = task.isCompleted!
        cell.delegate = self
        
        return cell
    }
}

// MARK: TaskTableViewCellDelegate methods

extension TasksViewController: TaskTableViewCellDelegate {
    func showEditTask(for taskId: UUID) {
        selectedTask = dataManager.getTaskById(for: taskId)
        
        if let _ = selectedTask {
            self.performSegue(withIdentifier: "showEditTask", sender: self)
        }
    }
    
    func toggleTaskComplete(for taskId: UUID, using button: TaskStatusUIButton) {
        let taskToToggle = dataManager.getTaskById(for: taskId)
        
        guard var taskToToggle = taskToToggle else {
            return
        }
        
        taskToToggle.isCompleted!.toggle()
        
        if taskToToggle.isCompleted == true {
            taskToToggle.completionDate = Utility.getCurrentDate()
        } else {
            taskToToggle.completionDate = nil
        }
        
        let updatedTask = taskToToggle
        
        _Concurrency.Task {
            await _Concurrency.Task.sleep(750_000_000)
            
            if button.isChecked {
                await dataManager.updateTask(using: updatedTask)
                await dataManager.fetchTasks()
                
                tasksTableView.reloadData()
            }
        }
    }
    
    func deleteTask(for taskId: UUID?) {
        let taskToDelete = dataManager.getTaskById(for: taskId)
        
        if let taskToDelete = taskToDelete,
           let taskIndex = dataManager.getTaskIndexById(for: taskToDelete.id) {
            dataManager.deleteTask(at: taskIndex)
            tasksTableView.reloadData()
        }
    }
}


// MARK: Private methods

extension TasksViewController {
    private func initialize() async {
        isInitializing = true
        await dataManager.fetchTasks()
        
        isInitializing = false
    }
    
    private func showEmptyMsg() {
        let emptyMsg = UILabel(frame: CGRect(x: 0, y: 0, width: tasksTableView.frame.width, height: tasksTableView.frame.height))
        emptyMsg.textAlignment = .center
        emptyMsg.text = "No tasks for today."

        tasksTableView.backgroundView = emptyMsg
        tasksTableView.separatorStyle = .none
    }
}
