//
//  AddEditTaskViewController.swift
//  TiskTasker
//
//  Created by Jon Schlandt on 10/15/22.
//

import UIKit

class AddEditTaskViewController: UIViewController {
    var task: Task?
    var taskAction = TaskAction.Add
    
    @IBOutlet var addEditTaskView: AddEditTaskView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        switch taskAction {
        case .Add:
            navigationItem.rightBarButtonItems?[0].title = "Add"
        case .Edit:
            navigationItem.rightBarButtonItems?[0].title = "Edit"
            mapTaskDataToView()
        }
        
        addEditTaskView.taskDescTextView.delegate = self
        addEditTaskView.style(for: taskAction)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    private func mapTaskDataToView() {
        if let task = task {
            addEditTaskView.taskTitleTextField.text = task.title
            addEditTaskView.taskDescTextView.text = task.description
            addEditTaskView.setTaskPoints(points: task.points )
        }
    }
}

extension AddEditTaskViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        addEditTaskView.taskDescPlaceholder.isHidden = !addEditTaskView.taskDescTextView.text.isEmpty
    }
}
