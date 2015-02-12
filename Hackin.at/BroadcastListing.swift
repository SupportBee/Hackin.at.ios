//
//  BroadcastListing.swift
//  Hackin.at
//
//  Created by Avinasha Shastry on 11/02/15.
//  Copyright (c) 2015 Prateek Dayal. All rights reserved.
//

import UIKit
import PureLayout

class BroadcastListing: UIView {

    var tableView = UITableView()
    
    var tableViewDataSource: BroadcastTableViewDataSource!
    var tableViewDelegate: UITableViewDelegate!
    var tableRefreshControl:TableRefreshControl!

    
    override init (frame : CGRect) {
        super.init(frame : frame)
    }

    
    convenience init(tableViewDataSource: BroadcastTableViewDataSource, tableViewDelegate: UITableViewDelegate, pullToRefresh:Bool = false){

        self.init(frame:CGRectZero)
        
        self.tableViewDataSource = tableViewDataSource
        self.tableViewDelegate = tableViewDelegate
        
        setupTableViewWiring()
        setupTableViewStyle()
        setupTableViewConstraints()
        
        if(pullToRefresh == true){ setupPullToRefresh() }
    }
    
    required init(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
    }
   
    func fetchAndRefresh(success: () -> () = {}){
        func onFetch(){
            refresh()
            success()
        }
        
        tableViewDataSource.fetchBroadcasts(success: onFetch)
    }
    
    func refresh(){
        self.tableView.reloadData()
    }
   
    func setBroadcasts(broadcasts: [Broadcast]){
        tableViewDataSource.broadcasts = broadcasts
    }
    
    func onPullToRefresh(){
        fetchAndRefresh(success: { self.tableRefreshControl.endRefreshing() })
    }
    
    private func setupPullToRefresh(){
        tableRefreshControl = TableRefreshControl.setupForTableViewWithAction(
            tableView: tableView,
            target: self,
            action: "onPullToRefresh"
        )
    }
    
    private func setupTableViewWiring(){
        tableView.delegate = self.tableViewDelegate
        tableView.dataSource = self.tableViewDataSource
        tableView.registerNib(
            UINib(nibName:"BroadcastTableViewCell", bundle:nil), forCellReuseIdentifier: "BroadcastCell")
        self.addSubview(tableView)
    }
    
    private func setupTableViewStyle(){
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.separatorInset = UIEdgeInsetsZero
    }
    
    private func setupTableViewConstraints() {
        tableView.autoPinEdgeToSuperviewEdge(ALEdge.Top)
        tableView.autoPinEdgeToSuperviewEdge(ALEdge.Bottom)
        tableView.autoPinEdgeToSuperviewEdge(ALEdge.Right)
        tableView.autoPinEdgeToSuperviewEdge(ALEdge.Left)
    }
}
