//
//  HistoryTableViewCell.swift
//  TiskTasker
//
//  Created by Jon Schlandt on 7/18/22.
//

import UIKit

protocol HistoryTableViewCellDelegate: AnyObject {
    func showTaskDetails(for taskId: Int)
}

class HistoryTableViewCell: UITableViewCell {
    @IBOutlet var taskTitleLabel: UILabel!
    @IBOutlet var taskDetailsUIButton: UIButton!
    
    var taskId: Int?
    var delegate: HistoryTableViewCellDelegate?
    
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
