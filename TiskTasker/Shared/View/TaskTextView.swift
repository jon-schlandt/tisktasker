//
//  TaskTextView.swift
//  TiskTasker
//
//  Created by Jon Schlandt on 10/12/22.
//

import UIKit

class TaskTextView: UITextView {
    @IBInspectable var inset: CGFloat = 0
    
    override

    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: inset, dy: inset)
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return textRect(forBounds: bounds)
    }
}
