//
//  HomeViewController.swift
//  TiskTasker
//
//  Created by Jon Schlandt on 10/22/22.
//

import UIKit

class HomeViewController: UITabBarController {
    @IBOutlet var homeViewTabBar: HomeViewTabBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        homeViewTabBar.style()
    }
}
