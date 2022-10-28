//
//  TasksNavigationController.swift
//  TiskTasker
//
//  Created by Jon Schlandt on 10/23/22.
//

import UIKit

class TasksNavigationController: BaseNavigationController {
    @IBOutlet var tasksNavigationBar: BaseNavigationBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tasksNavigationBar.style()
    }
}
