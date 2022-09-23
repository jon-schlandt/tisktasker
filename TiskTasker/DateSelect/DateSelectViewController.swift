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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        datePicker.date = date
    }
    
    @IBAction func setDate(sender: UIDatePicker) {
        date = sender.date
        delegate?.setSelectedDate(to: date)
    }
}
