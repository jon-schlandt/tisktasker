//
//  StatsNavigationController.swift
//  TiskTasker
//
//  Created by Jon Schlandt on 10/27/22.
//

import UIKit

class StatsNavigationController: BaseNavigationController {
    @IBOutlet var statsNavigationBar: BaseNavigationBar!

    override func viewDidLoad() {
        super.viewDidLoad()
        statsNavigationBar.style()
    }
}
