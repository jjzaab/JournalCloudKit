//
//  EntryListTableViewController.swift
//  JournalCloudKit
//
//  Created by XMS_JZhan on 2/25/19.
//  Copyright © 2019 XMS_JZhan. All rights reserved.
//

import UIKit

class EntryListTableViewController: UITableViewController {
    
    private let entryController = EntryController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        entryController.fetchEntries { (success) in
            if success {
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        entryController.fetchEntries { (success) in
            if success {
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return entryController.entries.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "entryCell", for: indexPath)
        cell.textLabel?.text = entryController.entries[indexPath.row].title
        cell.detailTextLabel?.text = entryController.entries[indexPath.row].text
        return cell
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //IIDOO
        if segue.identifier == "editSegue" {
            if let destinationVC = segue.destination as? EntryDetailViewController {
                if let indexPath = tableView.indexPathForSelectedRow {
                    destinationVC.entry = entryController.entries[indexPath.row]
                }
            }
        }
    }
}
