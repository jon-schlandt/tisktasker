//
//  StatsViewController.swift
//  TiskTasker
//
//  Created by Jon Schlandt on 7/22/22.
//

import UIKit

class StatsViewController: UITableViewController {
    let manager = StatsDataManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        manager.fetch()
    }
    
    private func initialize() {
        manager.fetch()
    }
}
