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
    
    func setupFriendsListing(){
        friendsListing = HackersListingView(cellStyle: HackerTableCellStyle.FullView, pullToRefresh: true)
        view.addSubview(friendsListing)
        friendsListing.fetchFriends()
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
        let vc = searchStoryboard.instantiateViewControllerWithIdentifier("searchNavigationController") as UINavigationController;
        self.presentViewController(vc, animated: false, completion: nil)
        
    }
    

    
}