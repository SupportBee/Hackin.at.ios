//
//  SearchViewController.swift
//  Hackin.at
//
//  Created by Prateek on 3/5/15.
//  Copyright (c) 2015 Prateek Dayal. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource {
    
    var hackersFound: [Hacker]!
    var hackersListing: UITableView!
    
    var hackers: [Hacker] = []
    
    override func viewDidLoad(){
        println("Search view controller")
        setupHackerListingView()
        setupSearchBar()
    }
    
    func setupSearchBar(){
        let searchBar = UISearchBar()
        searchBar.delegate = self
        searchBar.showsCancelButton = true
        searchBar.placeholder = "Search Github Hackers"
        navigationItem.titleView = searchBar
        searchBar.becomeFirstResponder()
    }
    
    override func updateViewConstraints() {
        hackersListing.autoPinEdgesToSuperviewEdgesWithInsets(UIEdgeInsetsZero)
        super.updateViewConstraints()
    }
    
    func setupHackerListingView(){
        hackersListing = UITableView()
        hackersListing.dataSource = self
        hackersListing.delegate = self
        hackersListing.registerClass(UITableViewCell.self, forCellReuseIdentifier: "HackerCell")
        view.addSubview(hackersListing)
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        println("Searching for \(searchText)")
        Hacker.search(searchText, success: foundHackers)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return hackers.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = hackersListing.dequeueReusableCellWithIdentifier("HackerCell") as! UITableViewCell
        let hacker = self.hackers[indexPath.row]
        cell.textLabel?.text  = "@\(hacker.login)"
        
        Helpers.showProfileImage(hacker, imageView: cell.imageView!)
        Helpers.roundImageView(cell.imageView!)
        
        cell.accessoryView = SendFriendshipRequestButton(toBeFriend: hacker)
        return cell;
    }
    
    func foundHackers(hackers: [Hacker]){
        self.hackers = hackers
        hackersListing.reloadData()
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        self.dismissViewControllerAnimated(false, completion: nil)
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let hacker = self.hackers[indexPath.row]
        let vc = AppScreens.Profile(hacker).vc
        navigationController?.pushViewController(vc, animated: true)
    }
}