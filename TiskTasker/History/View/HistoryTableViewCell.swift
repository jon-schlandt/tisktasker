//
//  HistoryTableViewCell.swift
//  TiskTasker
//
//  Created by Jon Schlandt on 7/18/22.
//

import UIKit

protocol HistoryTableViewCellDelegate {
    func showTaskDetails(for taskId: Int)
}

class HistoryTableViewCell: UITableViewCell {
    var taskId: Int?
    var delegate: HistoryTableViewCellDelegate?
    
    @IBOutlet var taskTitleLabel: UILabel!
    @IBOutlet var taskDetailsUIButton: UIButton!
    
    @IBAction func showTaskDetails() {
        if let taskId = taskId {
            delegate?.showTaskDetails(for: taskId)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
