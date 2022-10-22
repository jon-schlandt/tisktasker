//
//  TasksNavigationController.swift
//  TiskTasker
//
//  Created by Jon Schlandt on 10/8/22.
//

import UIKit

class TasksNavigationController: UINavigationController {
    @IBOutlet var tasksNavigationBar: TasksNavigationBar!
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tasksNavigationBar.style()
    }
}
