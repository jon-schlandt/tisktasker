//
//  HistoryViewController.swift
//  TiskTasker
//
//  Created by Jon Schlandt on 7/6/22.
//

import UIKit

class HistoryViewController: UIViewController, UITableViewDataSource {
    @IBAction func unwindLocationCancel(segue: UIStoryboardSegue) {}
    let manager = HistoryDataManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
    
    private func initialize() {
        manager.fetch()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "historyCell", for: indexPath)
        return cell
    }
}
