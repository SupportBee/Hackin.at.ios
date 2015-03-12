//
//  SearchViewController.swift
//  Hackin.at
//
//  Created by Prateek on 3/5/15.
//  Copyright (c) 2015 Prateek Dayal. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UISearchBarDelegate {
    
    var hackersFound: [Hacker]!
    
    override func viewDidLoad() {
        println("Search view controller")
        let searchBar = UISearchBar()
        searchBar.delegate = self
        searchBar.showsCancelButton = true
        searchBar.placeholder = "Search Github Hackers"
        navigationItem.titleView = searchBar
        searchBar.becomeFirstResponder()
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        println("Searching for \(searchText)")
        Hacker.search(searchText, success: foundHackers)
    }
    
    func foundHackers(hackers: [Hacker]?){
        println("Found \(hackers!.count)")
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        self.dismissViewControllerAnimated(false, completion: nil)
    }
}