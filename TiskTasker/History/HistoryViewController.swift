//
//  HistoryViewController.swift
//  TiskTasker
//
//  Created by Jon Schlandt on 7/6/22.
//

import UIKit

class HistoryViewController: UIViewController {
    let dataManager = TaskDataManager()
    var selectedTask: Task?
    var selectedDate: Date?
    var hasInitialized = false
    
    @IBOutlet var historyTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        historyTableView.register(HistoryTableViewHeader.self, forHeaderFooterViewReuseIdentifier: HistoryTableViewHeader.reuseIdentifier)
        historyTableView.separatorStyle = .none
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        _Concurrency.Task {
            await initialize()
            historyTableView.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showTaskDetails" {
            if let destination = segue.destination as? TaskDetailsViewController,
               let selectedTask = selectedTask {
                destination.selectedTask = selectedTask
            }
            
            return
        }
        
        if segue.identifier == "showDateSelect" {
            guard let destination = segue.destination as? DateSelectViewController else {
                return
            }
            
            if let selectedDate = selectedDate {
                destination.date = selectedDate
            }
            
            destination.delegate = self
        }
    }
}

// MARK: UITableViewDataSource methods

extension HistoryViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !dataManager.tasks.isEmpty {
            historyTableView.backgroundView = nil
            return dataManager.getTaskCount()
        }
        
        if hasInitialized {
            showEmptyMsg()
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "historyCell", for: indexPath) as! HistoryTableViewCell
        let task = dataManager.getTaskByIndex(at: indexPath.row)
        
        if let id = task.id {
            cell.taskId = id
        }
        
        if let title = task.title {
            cell.taskTitleLabel.text = title
        }
        
        cell.delegate = self
        return cell
    }
}

// MARK: UITableViewDelegate methods

extension HistoryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        72
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: HistoryTableViewHeader.reuseIdentifier) as? HistoryTableViewHeader else {
            return nil
        }
        
        headerView.setDateLabel(using: selectedDate)
        return headerView
    }
}

// MARK: HistoryTableViewCellDelegate methods

extension HistoryViewController: HistoryTableViewCellDelegate {
    func showTaskDetails(for taskId: UUID) {
        selectedTask = dataManager.getTaskById(for: taskId)
        self.performSegue(withIdentifier: "showTaskDetails", sender: self)
    }
}

// MARK: DateSelectViewControllerDelegate methods

extension HistoryViewController: DateSelectViewControllerDelegate {
    func setSelectedDate(to date: Date) {
        selectedDate = date
    }
}

// MARK: Private methods

extension HistoryViewController {
    private func initialize() async {
        if let selectedDate = selectedDate {
            await dataManager.fetchTasks(for: selectedDate)
        } else {
            await dataManager.fetchTasks(for: Date())
        }
        
        hasInitialized = true
    }
    
    private func showEmptyMsg() {
        let emptyMsg = EmptyMsg(frame: CGRect(x: 0, y: 0, width: historyTableView.frame.width, height: historyTableView.frame.height))
        emptyMsg.text = "No completed tasks."

        historyTableView.backgroundView = emptyMsg
    }
}
