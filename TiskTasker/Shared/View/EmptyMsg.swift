//
//  NoTasksMsg.swift
//  TiskTasker
//
//  Created by Jon Schlandt on 10/27/22.
//

import UIKit

class EmptyMsg: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        font = UIFont(name: "Helvetica Neue Light", size: 18)
        textAlignment = .center
        textColor = UIColor.init(hex: "#929292ff")
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
