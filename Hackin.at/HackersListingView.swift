//
//  HackersListing.swift
//  Hackin.at
//
//  Created by Prateek on 3/5/15.
//  Copyright (c) 2015 Prateek Dayal. All rights reserved.
//

import UIKit
import PureLayout

class HackersListingView: UIView, UITableViewDelegate, UITableViewDataSource {
   
    var hackersTableView = UITableView()
    var hackers: Array<Hacker> = []
    var tableRefreshControl:TableRefreshControl!
    
    override init (frame : CGRect) {
        super.init(frame : frame)
    }
    
    convenience init(pullToRefresh:Bool = true){
        self.init(frame:CGRectZero)
        setupTableViewWiring()
        addSubview(hackersTableView)
        setupTableViewStyle()
        setupAutoRefresh()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setupTableViewWiring(){
        hackersTableView.delegate = self
        hackersTableView.dataSource = self
        //hackersTableView.registerNib(UINib(nibName: "HackerTableViewCell", bundle: nil), forCellReuseIdentifier: "HackerCell")
        //hackersTableView.registerClass(HackerTableViewCell.self, forCellReuseIdentifier: "HackerCell")
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
    
    
    override func updateConstraints() {
   //     hackersTableView.autoPinEdgesToSuperviewMargins()
        hackersTableView.autoPinEdgesToSuperviewEdgesWithInsets( UIEdgeInsetsZero)
        super.updateConstraints()
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
        self.hackers = hackers
        self.hackersTableView.reloadData()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        println("total \(hackers.count)")
        return hackers.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        println("rendering hacker ")
        let cell = HackerTableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "HackerCell")
        
        let hacker = self.hackers[indexPath.row]
        cell.setupViewData(hacker)
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let hacker = self.hackers[indexPath.row]
        var hackersStoryboard = UIStoryboard(name: "Hackers", bundle: nil);
        let vc = hackersStoryboard.instantiateViewControllerWithIdentifier("profileViewController") as ProfileViewController
        vc.hacker = hacker
//        self.navigationController?.pushViewController(vc, animated: true)
    }
}