//
//  FriendsViewController.swift
//  Hackin.at
//
//  Created by Prateek on 3/4/15.
//  Copyright (c) 2015 Prateek Dayal. All rights reserved.
//


import UIKit
import PureLayout

class FriendsViewController: UINavigationController {
    
    override func viewDidLoad() {
        let searchBar = UISearchBar()
        self.navigationItem.titleView = searchBar
    }
    
}