//
//  HistoryTableViewHeader.swift
//  TiskTasker
//
//  Created by Jon Schlandt on 7/28/22.
//

import UIKit

class HistoryTableViewHeader: UITableViewHeaderFooterView {
    static let reuseIdentifier: String = String(describing: self)
    var dateLabel = UILabel()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(dateLabel)
        styleDateLabel()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setDateLabel(using selectedDate: Date?) {
        var dateToSet: Date
        
        if let selectedDate = selectedDate {
            dateToSet = selectedDate
        } else {
            dateToSet = Date()
        }
        
        let isToday = Calendar.current.isDate(dateToSet, equalTo: Date(), toGranularity: .day)
        
        if isToday {
            dateLabel.text = "Today"
        } else {
            dateLabel.text = DateUtil().formatDate(from: dateToSet, as: "MMM d, yyyy")
        }
    }
    
    private func styleDateLabel() {
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        
        dateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24).isActive = true
        dateLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        dateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24).isActive = true
        
        dateLabel.font = UIFont(name: "Helvetica Neue Medium", size: 22)
    }
}
