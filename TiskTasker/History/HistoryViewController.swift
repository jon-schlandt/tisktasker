//
//  HistoryViewController.swift
//  TiskTasker
//
//  Created by Jon Schlandt on 7/6/22.
//

import UIKit

class HistoryViewController: UIViewController {
    let manager = HistoryDataManager()
    var selectedTask: Task?
    
    @IBOutlet var historyTableView: UITableView!
    @IBAction func unwindLocationCancel(segue: UIStoryboardSegue) {}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showTaskDetails" {
            if let destination = segue.destination as? UINavigationController,
               let viewController = destination.visibleViewController as? TaskDetailsViewController,
               let selectedTask = selectedTask {
                viewController.selectedTask = selectedTask
            }
        }
    }
}

// MARK: UITableViewDataSource methods

extension HistoryViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if manager.tasks.isEmpty {
            showEmptyMsg()
            return 0
        }
        
        historyTableView.backgroundView = nil
        return manager.getTaskCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "historyCell", for: indexPath) as! HistoryTableViewCell
        let task = manager.getTaskByIndex(at: indexPath.row)
        
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
        UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: TableViewHeader.reuseIdentifier) as? TableViewHeader else {
            return nil
        }
        
        headerView.label.text = "Today"
        return headerView
    }
}

// MARK: HistoryTableViewCellDelegate methods

extension HistoryViewController: HistoryTableViewCellDelegate {
    func showTaskDetails(for taskId: Int) {
        selectedTask = manager.getTaskById(for: taskId)
        self.performSegue(withIdentifier: "showTaskDetails", sender: self)
    }
}

// MARK: Private methods

extension HistoryViewController {
    private func initialize() {
        historyTableView.register(TableViewHeader.self, forHeaderFooterViewReuseIdentifier: TableViewHeader.reuseIdentifier)
        historyTableView.separatorStyle = .none
        
        manager.fetch(for: Date())
    }
    
    private func showEmptyMsg() {
        let emptyMsg = UILabel(frame: CGRect(x: 0, y: 0, width: historyTableView.frame.width, height: historyTableView.frame.height))
        emptyMsg.textAlignment = .center
        emptyMsg.text = "No completed tasks."

        historyTableView.backgroundView = emptyMsg
    }
}
