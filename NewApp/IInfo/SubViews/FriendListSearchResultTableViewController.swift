//
//  SearchResultTableViewController.swift
//  NewApp
//
//  Created by Yu-Chih Shen on 2024/1/13.
//

import UIKit

class FriendListSearchResultTableViewController: UITableViewController, UISearchResultsUpdating {
    
    let friendCellIdentifier = "FriendViewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: friendCellIdentifier, bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: friendCellIdentifier)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: friendCellIdentifier) as! FriendViewCell
        return cell
    }
    
    // MARK: - UISearchResultsUpdating
    func updateSearchResults(for searchController: UISearchController) {
        
    }
}
