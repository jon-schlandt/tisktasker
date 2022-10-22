//
//  TasksNavigationBar.swift
//  TiskTasker
//
//  Created by Jon Schlandt on 10/15/22.
//

import UIKit

class TasksNavigationBar: UINavigationBar {
    func style() {
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.configureWithDefaultBackground()
        navigationBarAppearance.backgroundColor = .black
        navigationBarAppearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationBarAppearance.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont(name: "Helvetica Neue Bold", size: 24)!]
        
        tintColor = .white
        
        standardAppearance = navigationBarAppearance
        compactAppearance = navigationBarAppearance
        scrollEdgeAppearance = navigationBarAppearance
    }
}
