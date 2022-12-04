//
//  ProgressNavigationController.swift
//  TiskTasker
//
//  Created by Jon Schlandt on 10/27/22.
//

import UIKit

class ProgressNavigationController: BaseNavigationController {
    @IBOutlet var progressNavigationBar: BaseNavigationBar!

    override func viewDidLoad() {
        super.viewDidLoad()
        progressNavigationBar.style()
    }
}
