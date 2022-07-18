//
//  HistoryTableViewCell.swift
//  TiskTasker
//
//  Created by Jon Schlandt on 7/18/22.
//

import UIKit

class HistoryTableViewCell: UITableViewCell {
    @IBOutlet var taskTitleLabel: UILabel!
    @IBOutlet var taskDetailsUIButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
