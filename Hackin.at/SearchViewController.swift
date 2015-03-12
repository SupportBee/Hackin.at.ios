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
    var hackersListing: HackersListingView!
    
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
        hackersListing = HackersListingView(cellStyle: HackerTableCell.FullView.self,
            pullToRefresh: false)
        view.addSubview(hackersListing)
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        println("Searching for \(searchText)")
        Hacker.search(searchText, success: foundHackers)
    }
    
    func foundHackers(hackers: [Hacker]){
        hackersListing.renderHackers(hackers)
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        self.dismissViewControllerAnimated(false, completion: nil)
    }
}