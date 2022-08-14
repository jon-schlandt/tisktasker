//
//  TaskStatusUIButton.swift
//  TiskTasker
//
//  Created by Jon Schlandt on 7/16/22.
//

import UIKit

class TaskStatusUIButton: UIButton {
    func setStatusImage(toCompleted isCompleted: Bool?) {
        guard let isCompleted = isCompleted else {
            return
        }
        
        if !isCompleted {
            self.setImage(UIImage(systemName: "square"), for: .normal)
        } else {
            self.setImage(UIImage(systemName: "checkmark.square.fill"), for: .normal)
        }
    }
}
