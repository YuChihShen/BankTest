//
//  FriendListViewController.swift
//  NewApp
//
//  Created by Yu-Chih Shen on 2024/1/13.
//

import UIKit

class FriendListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var friendListTable: UITableView!
    
    var friendList:[Friend] = [] {
        didSet {
            if (self.isSearchActive) {
                if searchBar.text?.count ?? 0 > 0 {
                    self.filteredFriendList = friendList.filter({ $0.name.contains(searchBar.text ?? "") })
                    self.friendListTable.reloadData()
                } else {
                    self.filteredFriendList = friendList
                    self.friendListTable.reloadData()
                }
            }
        }
    }
    var filteredFriendList:[Friend] = []
    var isSearchActive = false
    let friendCellIdentifier = "FriendViewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        friendListTable.delegate = self
        friendListTable.dataSource = self
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action:  #selector(endEditing))
        friendListTable.addGestureRecognizer(gestureRecognizer)
        
        let nib = UINib(nibName: friendCellIdentifier, bundle: nil)
        friendListTable.register(nib, forCellReuseIdentifier: friendCellIdentifier)
        
        self.searchBar.delegate = self
    }
    
    @objc func endEditing() {
        self.view.endEditing(false)
    }
    
    
    // MARK: - TableViewDelegate
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (isSearchActive) ? filteredFriendList.count : friendList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: friendCellIdentifier) as! FriendViewCell
        cell.configureCellWithFriend(friend: isSearchActive ? filteredFriendList[indexPath.row] : friendList[indexPath.row])
        return cell
    }
    
    // MARK: - UISearchBarDelegate
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.isSearchActive = true
        self.filteredFriendList = friendList
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count ?? 0 > 0 {
            self.filteredFriendList = friendList.filter({ $0.name.contains(searchText) })
            self.friendListTable.reloadData()
        } else {
            self.filteredFriendList = friendList
            self.friendListTable.reloadData()
        }
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        self.isSearchActive = false
    }
    

}
