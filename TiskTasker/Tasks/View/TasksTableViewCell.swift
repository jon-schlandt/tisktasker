//
//  TasksTableViewCell.swift
//  TiskTasker
//
//  Created by Jon Schlandt on 7/16/22.
//

import UIKit

protocol TaskTableViewCellDelegate {
    func toggleTaskComplete(for taskId: Int?, using button: TaskStatusUIButton)
    func showEditTask(for taskId: Int?)
}

class TasksTableViewCell: UITableViewCell {
    var taskId: Int?
    var delegate: TaskTableViewCellDelegate?
    
    @IBOutlet var taskTitleLabel: UILabel!
    @IBOutlet var taskCompleteButton: TaskStatusUIButton!
    @IBOutlet var editTaskUIButton: UIButton!
    
    @IBAction func showEditTask() {
        delegate?.showEditTask(for: taskId)
    }
    
    @IBAction func toggleTaskComplete() {
        delegate?.toggleTaskComplete(for: taskId, using: taskCompleteButton)
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
