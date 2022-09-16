//
//  TaskStatusUIButton.swift
//  TiskTasker
//
//  Created by Jon Schlandt on 7/16/22.
//

import UIKit

class TaskStatusUIButton: UIButton {
    var isChecked = false {
        didSet {
            setStatusImage(when: isChecked)
        }
    }
    
    func toggle() {
        isChecked = !isChecked
    }
    
    func setStatusImage(when isChecked: Bool) {
        if !isChecked {
            self.setImage(UIImage(systemName: "square"), for: .normal)
        } else {
            self.setImage(UIImage(systemName: "checkmark.square.fill"), for: .normal)
        }
    }
}
