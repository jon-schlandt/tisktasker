//
//  BaseNavigationController.swift
//  TiskTasker
//
//  Created by Jon Schlandt on 10/8/22.
//

import UIKit

class BaseNavigationController: UINavigationController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
