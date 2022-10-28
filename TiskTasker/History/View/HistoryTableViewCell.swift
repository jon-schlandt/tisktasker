//
//  HistoryTableViewCell.swift
//  TiskTasker
//
//  Created by Jon Schlandt on 7/18/22.
//

import UIKit

protocol HistoryTableViewCellDelegate {
    func showTaskDetails(for taskId: UUID)
}

class HistoryTableViewCell: UITableViewCell {
    var taskId: UUID?
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
        style()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    private func style() {
        let bottomBorder = CALayer()
        bottomBorder.frame = CGRect(x: 24, y: self.frame.height - 1, width: self.frame.width, height: 1)
        bottomBorder.backgroundColor = UIColor.systemGray5.cgColor
        self.layer.addSublayer(bottomBorder)
        
        taskTitleLabel.font = UIFont(name: "Helvetica Neue", size: 17)
    }
}
