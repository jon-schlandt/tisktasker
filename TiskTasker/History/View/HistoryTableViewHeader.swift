//
//  HistoryTableViewHeader.swift
//  TiskTasker
//
//  Created by Jon Schlandt on 7/28/22.
//

import UIKit

class HistoryTableViewHeader: UITableViewHeaderFooterView {
    static let reuseIdentifier: String = String(describing: self)
    var label = UILabel()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(label)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 24),
            label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -24)
        ])
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setLabel(using date: Date) {
        let isToday = Calendar.current.isDate(date, equalTo: Date(), toGranularity: .day)
        
        if isToday {
            label.text = "Today"
        } else {
            label.text = DateUtil().formatDate(from: date, as: "MMM d, yyyy")
        }
    }
}
