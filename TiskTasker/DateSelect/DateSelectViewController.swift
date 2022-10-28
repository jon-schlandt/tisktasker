//
//  DateSelectViewController.swift
//  TiskTasker
//
//  Created by Jon Schlandt on 9/19/22.
//

import UIKit

protocol DateSelectViewControllerDelegate {
    func setSelectedDate(to date: Date)
}

class DateSelectViewController: UIViewController {
    var date = Date()
    var delegate: DateSelectViewControllerDelegate?
    
    @IBOutlet var datePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        datePicker.maximumDate = Date()
        styleDatePicker()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        datePicker.date = date
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    @IBAction func setDate(sender: UIDatePicker) {
        date = sender.date
        delegate?.setSelectedDate(to: date)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
            self.navigationController?.popToRootViewController(animated: true)
        }
    }
    
    private func styleDatePicker() {
        datePicker.tintColor = .black
    }
}
