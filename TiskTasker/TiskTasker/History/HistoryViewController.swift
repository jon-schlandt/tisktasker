//
//  HistoryViewController.swift
//  TiskTasker
//
//  Created by Jon Schlandt on 7/6/22.
//

import UIKit

class HistoryViewController: UIViewController, UITableViewDataSource {
    @IBAction func unwindLocationCancel(segue: UIStoryboardSegue) {}
    
    let manager = HistoryDataManager()
    var selectedTask: CompletedTask?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showTaskDetails" {
            if let navigationController = segue.destination as? UINavigationController,
               let viewController = navigationController.visibleViewController as? TaskDetailsViewController,
               let selectedTask = selectedTask {
                viewController.selectedTask = selectedTask
            }
//            print("here")
        }
    }
    
    private func initialize() {
        manager.fetch()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        manager.getTaskCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "historyCell", for: indexPath) as! HistoryTableViewCell
        let task = manager.getTaskByIndex(at: indexPath.row)
        
        cell.delegate = self
        cell.taskId = task.id
        cell.taskTitleLabel.text = manager.getTaskByIndex(at: indexPath.row).title
        
        return cell
    }
}

extension HistoryViewController: HistoryTableViewCellDelegate {
    func showTaskDetails(for taskId: Int) {
        selectedTask = manager.getTaskById(for: taskId)
        self.performSegue(withIdentifier: "showTaskDetails", sender: self)
    }
}
