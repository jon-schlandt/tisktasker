//
//  UIImageView.swift
//  TiskTasker
//
//  Created by Jon Schlandt on 10/29/22.
//

import Foundation
import UIKit

extension UIImageView {
    func round() {
        layer.masksToBounds = false
        layer.cornerRadius = frame.height / 2
        clipsToBounds = true
    }
}
