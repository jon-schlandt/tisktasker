//
//  HistoryNavigationController.swift
//  TiskTasker
//
//  Created by Jon Schlandt on 10/23/22.
//

import UIKit

class HistoryNavigationController: BaseNavigationController {
    @IBOutlet var historyNavigationBar: BaseNavigationBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        historyNavigationBar.style()
    }
}
