//
//  HistoryViewController.swift
//  TiskTasker
//
//  Created by Jon Schlandt on 7/6/22.
//

import UIKit

class HistoryViewController: UIViewController {
    let manager = HistoryDataManager()
    var selectedTask: CompletedTask?
    
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
    
    private func initialize() {
        self.historyTableView.register(TableViewHeader.self, forHeaderFooterViewReuseIdentifier: TableViewHeader.reuseIdentifier)
        manager.fetch()
    }
}

extension HistoryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        tableView.sectionHeaderTopPadding = 0
        
        guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: TableViewHeader.reuseIdentifier) as? TableViewHeader else {
            return nil
        }
        
        headerView.label.text = "Yesterday"
        return headerView
    }
}

extension HistoryViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        manager.getTaskCount()
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

extension HistoryViewController: HistoryTableViewCellDelegate {
    func showTaskDetails(for taskId: Int) {
        selectedTask = manager.getTaskById(for: taskId)
        self.performSegue(withIdentifier: "showTaskDetails", sender: self)
    }
}
