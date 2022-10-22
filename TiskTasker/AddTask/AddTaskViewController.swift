//
//  AddTaskViewController.swift
//  TiskTasker
//
//  Created by Jon Schlandt on 8/14/22.
//

import UIKit

class AddTaskViewController: UITableViewController {
    @IBOutlet var addTaskTableView: AddEditTaskTableView!
    @IBOutlet var addTaskNavigationItem: UINavigationItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addTaskTableView.style()
        addTaskNavigationItem.backBarButtonItem?.tintColor = .white
        addTaskNavigationItem.rightBarButtonItems?[0].tintColor = .white
    }
}
