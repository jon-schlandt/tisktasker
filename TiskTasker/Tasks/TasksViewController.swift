//
//  TasksViewController.swift
//  TiskTasker
//
//  Created by Jon Schlandt on 7/14/22.
//

import UIKit

class TasksViewController: UIViewController {
    private let taskDataManager = TaskDataManager()
    private let statsDataManager = StatsDataManager()
    private var selectedTask: Task?
    private var hasInitialized = false
    
    @IBOutlet var tasksTableView: UITableView!
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        _Concurrency.Task {
            await initialize()
            tasksTableView.reloadData()
        }
        
        navigationItem.rightBarButtonItems?[0].tintColor = .white
        tasksTableView.separatorStyle = .none
    }
    
    // MARK: Segues
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showEditTask" {
            if let destination = segue.destination as? AddEditTaskViewController,
               let selectedTask = selectedTask {
                destination.taskAction = .Edit
                destination.task = selectedTask
            }
        }
    }
    
    @IBAction func unwindAddEditTask(segue: UIStoryboardSegue) {
        guard let source = segue.source as? AddEditTaskViewController else {
            return
        }
        
        switch source.taskAction {
        case .Add:
            return addTask(from: source)
        case .Edit:
            return editTask(from: source)
        }
    }
    
    @IBAction func unwindDeleteTask(segue: UIStoryboardSegue) {
        guard let source = segue.source as? AddEditTaskViewController,
              let taskId = source.task?.id else {
                return
        }
        
        _Concurrency.Task {
            await taskDataManager.deleteTask(using: taskId)
            await taskDataManager.fetchTasks()
            
            tasksTableView.reloadData()
        }
    }
}

// MARK: UITableViewDataSource methods

extension TasksViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !taskDataManager.tasks.isEmpty {
            tasksTableView.backgroundView = nil
            return taskDataManager.getTaskCount()
        }
        
        if hasInitialized {
            showEmptyMsg()
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath) as! TasksTableViewCell
        let task = taskDataManager.getTaskByIndex(at: indexPath.row)
        
        cell.taskId = task.id
        cell.taskTitleLabel.text = task.title
        cell.taskCompleteButton.isChecked = task.isCompleted ?? false
        cell.delegate = self
        
        return cell
    }
}

// MARK: TaskTableViewCellDelegate methods

extension TasksViewController: TaskTableViewCellDelegate {
    func showEditTask(for taskId: UUID) {
        selectedTask = taskDataManager.getTaskById(for: taskId)
        
        if let _ = selectedTask {
            self.performSegue(withIdentifier: "showEditTask", sender: self)
        }
    }
    
    func toggleTaskComplete(for taskId: UUID, using button: TaskStatusUIButton) {
        let taskToToggle = taskDataManager.getTaskById(for: taskId)
        
        guard var taskToToggle = taskToToggle,
              let isCompleted = taskToToggle.isCompleted else {
                  return
        }
        
        taskToToggle.isCompleted = !isCompleted
        
        if taskToToggle.isCompleted == true {
            taskToToggle.completionDate = DateUtil().formatDate(from: Date())
        } else {
            taskToToggle.completionDate = nil
        }
        
        let toggledTask = taskToToggle
        
        _Concurrency.Task {
            await _Concurrency.Task.sleep(750_000_000)
            
            if button.isChecked {
                if let points = toggledTask.points {
                    await statsDataManager.incrementStats(by: points)
                }
                
                await taskDataManager.updateTask(using: toggledTask)
                await taskDataManager.fetchTasks()
                
                tasksTableView.reloadData()
            }
        }
    }
}

// MARK: Private methods

extension TasksViewController {
    private func initialize() async {
        await taskDataManager.fetchTasks()
        hasInitialized = true
    }
    
    private func showEmptyMsg() {
        let emptyMsg = EmptyMsg(frame: CGRect(x: 0, y: 0, width: tasksTableView.frame.width, height: tasksTableView.frame.height))
        emptyMsg.text = "No tasks for today."

        tasksTableView.backgroundView = emptyMsg
        tasksTableView.separatorStyle = .none
    }
    
    private func addTask(from source: AddEditTaskViewController) {
        let newTask = Task(
            title: source.addEditTaskView.taskTitleTextField.text,
            description: source.addEditTaskView.taskDescTextView.text,
            points: source.addEditTaskView.getTaskPoints()
        )
        
        _Concurrency.Task {
            await taskDataManager.addTask(using: newTask)
            await taskDataManager.fetchTasks()
            
            tasksTableView.reloadData()
        }
    }
    
    private func editTask(from source: AddEditTaskViewController) {
        guard let task = source.task else {
            return
        }
        
        let updatedTask = Task(
            id: task.id,
            title: source.addEditTaskView.taskTitleTextField.text,
            description: source.addEditTaskView.taskDescTextView.text,
            points: source.addEditTaskView.getTaskPoints(),
            isCompleted: task.isCompleted,
            enteredDate: task.enteredDate,
            completionDate: task.completionDate
        )
        
        _Concurrency.Task {
            await taskDataManager.updateTask(using: updatedTask)
            await taskDataManager.fetchTasks()
            
            tasksTableView.reloadData()
        }
    }
}
