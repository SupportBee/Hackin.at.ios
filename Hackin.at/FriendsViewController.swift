//
//  FriendsViewController.swift
//  Hackin.at
//
//  Created by Prateek on 3/4/15.
//  Copyright (c) 2015 Prateek Dayal. All rights reserved.
//


import UIKit
import PureLayout

class FriendsViewController: UINavigationController, UISearchBarDelegate {
    
    override func viewDidLoad() {
        let searchBar = UISearchBar()
        searchBar.delegate = self
        self.navigationItem.titleView = searchBar
    }
    
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        var searchStoryboard = UIStoryboard(name: "Search", bundle: nil);
        let vc = searchStoryboard.instantiateViewControllerWithIdentifier("searchViewController") as SearchViewController;
        presentViewController(vc, animated: false, completion: nil)
    }
    
}