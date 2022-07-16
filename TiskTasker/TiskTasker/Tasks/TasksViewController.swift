//
//  TasksViewController.swift
//  TiskTasker
//
//  Created by Jon Schlandt on 7/14/22.
//

import UIKit

class TasksViewController: UIViewController, UITableViewDataSource {
    @IBOutlet var tableView: UITableView!
    private let manager = TaskDataManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
    
    private func initialize() {
        manager.fetch()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        manager.getTaskCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath) as! TaskTableViewCell
        let task = manager.getTask(at: indexPath.row)
        
        cell.taskTitleLabel.text = task.title
        cell.taskCompleteButton.setStatusImage(isCompleted: task.isCompleted)
        return cell
    }
}
