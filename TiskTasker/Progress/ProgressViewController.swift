//
//  ProgressViewController.swift
//  TiskTasker
//
//  Created by Jon Schlandt on 7/22/22.
//

import UIKit

class ProgressViewController: UIViewController {
    let dataManager = ProgressDataManager()
    
    @IBOutlet var progressView: ProgressView!
    
    override func viewDidLoad() {
        progressView.style()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        _Concurrency.Task {
            await initialize()
            mapProgressDataToView()
        }
    }
}

// MARK: Private methods

extension ProgressViewController {
    private func initialize() async {
        await dataManager.fetchProgress()
    }
    
    private func mapProgressDataToView() {
        if let stats = dataManager.progress {
            if let fullName = stats.fullName {
                progressView.nameLabel.text = fullName
                progressView.initialsLabel.text = getInitials(from: fullName)
            }
            
            if let totalTasks = stats.totalTasks?.description {
                progressView.totalTasks.text = totalTasks
            }

            if let totalPoints = stats.totalPoints?.description {
                progressView.totalPoints.text = totalPoints
            }
        }
    }
    
    private func getInitials(from name: String) -> String {
        var initials = ""
        let names = name.components(separatedBy: " ")
        
        for name in names {
            initials += name[name.index(name.startIndex, offsetBy: 0)].uppercased()
        }
        
        return initials
    }
}
