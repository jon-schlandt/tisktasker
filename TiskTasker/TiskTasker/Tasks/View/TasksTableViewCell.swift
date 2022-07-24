//
//  TasksTableViewCell.swift
//  TiskTasker
//
//  Created by Jon Schlandt on 7/16/22.
//

import UIKit

protocol TaskTableViewCellDelegate {
    func editTask(for taskId: Int)
}

class TasksTableViewCell: UITableViewCell {
    var taskId: Int?
    var delegate: TaskTableViewCellDelegate?
    
    @IBOutlet var taskTitleLabel: UILabel!
    @IBOutlet var taskCompleteButton: TaskStatusUIButton!
    @IBOutlet var editTaskUIButton: UIButton!
    
    @IBAction func editTask() {
        if let taskId = taskId {
            delegate?.editTask(for: taskId)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
