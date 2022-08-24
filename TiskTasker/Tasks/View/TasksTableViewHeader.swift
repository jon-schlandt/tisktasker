//
//  TasksTableViewHeader.swift
//  TiskTasker
//
//  Created by Jon Schlandt on 7/26/22.
//

import UIKit

final class SectionHeaderView: UITableViewHeaderFooterView {
    static let reuseIdentifier: String = String(describing: self)

    var imageView: UIImageView

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)

        imageView = UIImageView()
        contentView.addSubview(imageView)

        imageView.translatesAutoresizingMaskIntoConstraints = false

        imageView.widthAnchor.constraint(equalToConstant: 24.0).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 24.0).isActive = true
        imageView.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor).isActive = true
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
