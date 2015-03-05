//
//  SearchViewController.swift
//  Hackin.at
//
//  Created by Prateek on 3/5/15.
//  Copyright (c) 2015 Prateek Dayal. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UISearchBarDelegate {
    
    override func viewDidLoad() {
        println("Search view controller")
        let searchBar = UISearchBar()
        searchBar.delegate = self
        navigationItem.titleView = searchBar
        searchBar.becomeFirstResponder()
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        println("Entered \(searchText)")
    }
}