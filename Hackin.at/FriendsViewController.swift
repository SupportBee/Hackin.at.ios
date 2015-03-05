//
//  FriendsViewController.swift
//  Hackin.at
//
//  Created by Prateek on 3/4/15.
//  Copyright (c) 2015 Prateek Dayal. All rights reserved.
//


import UIKit
import PureLayout

class FriendsViewController: UIViewController, UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var hackersTableView: UITableView!
    var hackers: Array<Hacker> = []
    var tableRefreshControl:TableRefreshControl!
    
    override func viewDidLoad() {
        setupSearchBar()
        setupFriendsListing()
  //      setupTableViewStyle()
  //      setupTableViewWiring()
  //      setupAutoRefresh()
  //      fetchFriends()
    }
    
    func setupFriendsListing(){
        let friendsListing = HackersListingView()
        view.addSubview(friendsListing)
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
    
    func setupTableViewWiring(){
        self.hackersTableView.delegate = self
        self.hackersTableView.dataSource = self
        self.hackersTableView.registerNib(UINib(nibName: "HackerTableViewCell", bundle: nil), forCellReuseIdentifier: "HackerCell")
    }
    
    func setupAutoRefresh(){
        tableRefreshControl = TableRefreshControl.setupForTableViewWithAction(
            tableView: self.hackersTableView,
            target: self,
            action: "refreshHackers"
        )
    }
    
    func setupTableViewStyle(){
        self.hackersTableView.estimatedRowHeight = 100
        self.hackersTableView.rowHeight = UITableViewAutomaticDimension
        self.hackersTableView.separatorInset = UIEdgeInsetsZero
    }
    
    override func updateViewConstraints() {
        self.hackersTableView.autoPinToTopLayoutGuideOfViewController(self, withInset: 0)
        self.hackersTableView.autoPinToBottomLayoutGuideOfViewController(self, withInset: 0)
        self.hackersTableView.autoPinEdgeToSuperviewEdge(ALEdge.Right)
        self.hackersTableView.autoPinEdgeToSuperviewEdge(ALEdge.Left)
        super.updateViewConstraints()
    }
    
    func refreshHackers(){
        func onFetch(hackers:[Hacker]){
            renderHackers(hackers)
            self.tableRefreshControl.endRefreshing()
        }
        CurrentHacker().friends(success: onFetch)
    }
    
    func fetchFriends(){
        CurrentHacker().friends(success: renderHackers)
    }
    
    func renderHackers(hackers:[Hacker]){
        println("Render \(hackers.count) Hackers")
        self.hackers = hackers
        self.hackersTableView.reloadData()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return hackers.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("HackerCell", forIndexPath: indexPath) as HackerTableViewCell
        
        let hacker = self.hackers[indexPath.row]
        cell.setupViewData(hacker)
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let hacker = self.hackers[indexPath.row]
        var hackersStoryboard = UIStoryboard(name: "Hackers", bundle: nil);
        let vc = hackersStoryboard.instantiateViewControllerWithIdentifier("profileViewController") as ProfileViewController
        vc.hacker = hacker
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}