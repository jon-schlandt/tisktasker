//
//  TasksTableViewCell.swift
//  TiskTasker
//
//  Created by Jon Schlandt on 7/16/22.
//

import UIKit

protocol TaskTableViewCellDelegate {
    func showEditTask(for taskId: UUID)
    func toggleTaskComplete(for taskId: UUID, using button: TaskStatusUIButton)
    func deleteTask(for taskId: UUID?)
}

class TasksTableViewCell: UITableViewCell {
    var taskId: UUID?
    var delegate: TaskTableViewCellDelegate?
    
    @IBOutlet var taskTitleLabel: UILabel!
    @IBOutlet var taskCompleteButton: TaskStatusUIButton!
    @IBOutlet var editTaskButton: UIButton!
    @IBOutlet var deleteTaskButton: UIButton!
    
    @IBAction func showEditTask() {
        guard let taskId = taskId else {
            return
        }
        
        delegate?.showEditTask(for: taskId)
    }
    
    @IBAction func toggleTaskComplete() {
        guard let taskId = taskId else {
            return
        }
        
        taskCompleteButton.toggle()
        delegate?.toggleTaskComplete(for: taskId, using: taskCompleteButton)
    }
    
    @IBAction func deleteTask() {
        delegate?.deleteTask(for: taskId)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let bottomBorder = CALayer()
        bottomBorder.frame = CGRect(x: 24, y: self.frame.height - 1, width: self.frame.width, height: 1)
        bottomBorder.backgroundColor = UIColor.systemGray5.cgColor
        
        self.layer.addSublayer(bottomBorder)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
