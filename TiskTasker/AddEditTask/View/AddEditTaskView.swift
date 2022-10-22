//
//  AddEditTaskView.swift
//  TiskTasker
//
//  Created by Jon Schlandt on 8/14/22.
//

import UIKit

class AddEditTaskView: UIView {
    
    var taskDescPlaceholder: UILabel!
    
    // MARK: Outlets
    
    @IBOutlet var taskTitleLabel: UILabel!
    @IBOutlet var taskDescLabel: UILabel!
    @IBOutlet var taskPointsLabel: UILabel!
    @IBOutlet var taskTitleTextField: AddEditTaskTextField!
    @IBOutlet var taskDescTextView: UITextView!
    @IBOutlet var taskPointsSegControl: UISegmentedControl!
    @IBOutlet var deleteTaskButton: UIButton!
    
    // MARK: Public methods
    
    func style(for taskAction: TaskAction) {
        styleLabels()
        styleTitleField()
        styleDescView()
        stylePointsControl()
        styleDeleteButton(for: taskAction)
    }
    
    func getTaskPoints() -> Int {
        switch taskPointsSegControl.selectedSegmentIndex {
        case 1:
            return 3
        case 2:
            return 5
        case 3:
            return 7
        case 4:
            return 9
        default:
            return 1
        }
    }
    
    func setTaskPoints(points: Int?) {
        switch points {
        case 3:
            taskPointsSegControl.selectedSegmentIndex = 1
        case 5:
            taskPointsSegControl.selectedSegmentIndex = 2
        case 7:
            taskPointsSegControl.selectedSegmentIndex = 3
        case 9:
            taskPointsSegControl.selectedSegmentIndex = 4
        default:
            taskPointsSegControl.selectedSegmentIndex = 0
        }
    }
    
}

// MARK: Styling

extension AddEditTaskView {
    private func styleLabels() {
        taskTitleLabel.font = UIFont(name: "Helvetica Neue Medium", size: 17)
        taskDescLabel.font = UIFont(name: "Helvetica Neue Medium", size: 17)
        taskPointsLabel.font = UIFont(name: "Helvetica Neue Medium", size: 17)
    }
    
    private func styleTitleField() {
        taskTitleTextField.backgroundColor = UIColor(red: 0.96, green: 0.96, blue: 0.96, alpha: 1.00)
        taskTitleTextField.clipsToBounds = true
        taskTitleTextField.layer.cornerRadius = 4
        taskTitleTextField.placeholder = "Conquer the world"
        taskTitleTextField.textColor = UIColor.init(hex: "#424242ff")
    }
    
    private func styleDescView() {
        taskDescTextView.backgroundColor = UIColor(red: 0.96, green: 0.96, blue: 0.96, alpha: 1.00)
        taskDescTextView.clipsToBounds = true
        taskDescTextView.layer.cornerRadius = 4
        taskDescTextView.autocapitalizationType = .none
        taskDescTextView.textColor = UIColor.init(hex: "#424242ff")
        
        taskDescPlaceholder = UILabel()
        taskDescPlaceholder.text = "But first, tacos..."
        taskDescPlaceholder.font = UIFont(name: "Helvetica Neue", size: 17)
        taskDescPlaceholder.textColor = .tertiaryLabel
        taskDescPlaceholder.sizeToFit()
        
        taskDescTextView.addSubview(taskDescPlaceholder)
        taskDescPlaceholder.frame.origin = CGPoint (x: 5, y: (taskDescTextView.font?.pointSize)! / 2)
        taskDescPlaceholder.isHidden = !taskDescTextView.text.isEmpty
    }
    
    private func stylePointsControl() {
        fixBackgroundSegmentControl(taskPointsSegControl)
        taskPointsSegControl.backgroundColor = UIColor(red: 0.96, green: 0.96, blue: 0.96, alpha: 1.00)
        taskPointsSegControl.selectedSegmentTintColor = .black
        taskPointsSegControl.setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "Helvetica Neue", size: 15)!], for: .normal)
        taskPointsSegControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont(name: "Helvetica Neue Medium", size: 15)!], for: .selected)
    }
    
    private func styleDeleteButton(for taskAction: TaskAction) {
        switch taskAction {
        case .Add:
            deleteTaskButton.isHidden = true
        case .Edit:
            deleteTaskButton.titleLabel?.font = UIFont(name: "Helvetica Neue Medium", size: 17)!
        }
    }
    
    private func fixBackgroundSegmentControl( _ segmentControl: UISegmentedControl){
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            for i in 0...(segmentControl.numberOfSegments - 1) {
                let backgroundSegmentView = segmentControl.subviews[i]
                backgroundSegmentView.isHidden = true
            }
        }
    }
}
