//
//  NoTasksMsg.swift
//  TiskTasker
//
//  Created by Jon Schlandt on 10/27/22.
//

import UIKit

class NoTasksMsg: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        font = UIFont(name: "Helvetica Neue", size: 18)
        textAlignment = .center
        textColor = UIColor.init(hex: "#929292ff")
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
