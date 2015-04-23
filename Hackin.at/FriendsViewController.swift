//
//  FriendsViewController.swift
//  Hackin.at
//
//  Created by Prateek on 3/4/15.
//  Copyright (c) 2015 Prateek Dayal. All rights reserved.
//


import UIKit
import PureLayout

class FriendsViewController: UIViewController, UISearchBarDelegate {
    
    var friendsListing: HackersListingView!
    
    override func viewDidLoad() {
        setupSearchBar()
        setupFriendsListing()
    }
    
    override func viewDidAppear(animated: Bool) {
        friendsListing.fetchHackers()
    }
    
    func setupFriendsListing(){
        friendsListing = HackersListingView(
            cellStyle: HackerTableCell.ContactView.self,
            emptyTableMessage: "Search and add some friends first.\n Be social!",
            pullToRefresh: true,
            hackersDataSource: MyFriendsDataSource())
        friendsListing.currentNavigationController = navigationController!
        view.addSubview(friendsListing)
    }
    
    override func updateViewConstraints() {
        friendsListing.autoPinEdgesToSuperviewEdgesWithInsets(UIEdgeInsetsZero)
        super.updateViewConstraints()
    }
    
    func setupSearchBar(){
        let searchBar = UISearchBar()
        searchBar.delegate = self
        searchBar.placeholder = "Search Github Hackers"
        self.navigationItem.titleView = searchBar
    }
    
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        var searchStoryboard = UIStoryboard(name: "Search", bundle: nil);
        let vc = searchStoryboard.instantiateViewControllerWithIdentifier("searchNavigationController") as! UINavigationController;
        self.presentViewController(vc, animated: false, completion: nil)
        
    }
    

    
}