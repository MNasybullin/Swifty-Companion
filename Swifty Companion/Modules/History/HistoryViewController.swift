//
//  HistoryViewController.swift
//  Swifty Companion
//
//  Created by OUT-Nasybullin-MR on 31.05.2021.
//

import UIKit

class HistoryViewController: UITableViewController {

    // MARK: Properties

    private var data: [String]!

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard data != nil else {
            fatalError("HistoryViewController: Data is nil.")
        }
    }
    
    // MARK: - UITableViewDataSource

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableCell", for: indexPath)
        
        return cell
    }

    // MARK: - UITableViewDelegate

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

    }
}
