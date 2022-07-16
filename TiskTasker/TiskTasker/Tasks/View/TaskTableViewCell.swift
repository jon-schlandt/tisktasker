//
//  TaskTableViewCell.swift
//  TiskTasker
//
//  Created by Jon Schlandt on 7/16/22.
//

import UIKit

class TaskTableViewCell: UITableViewCell {
    @IBOutlet var taskTitleLabel: UILabel!
    @IBOutlet var taskCompleteButton: TaskStatusUIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
