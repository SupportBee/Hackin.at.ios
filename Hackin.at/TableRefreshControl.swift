//
//  TableRefreshControl.swift
//  Hackin.at
//
//  Created by Avinasha Shastry on 11/02/15.
//  Copyright (c) 2015 Prateek Dayal. All rights reserved.
//

import Foundation

class TableRefreshControl {
    var refreshControl = UIRefreshControl()
    let tableView: UITableView
    
    class func setupForTableViewWithAction(#tableView: UITableView, target: AnyObject, action: String) -> TableRefreshControl{
        return TableRefreshControl(tableView: tableView, target: target, action: action)
    }
    
    init(tableView: UITableView, target: AnyObject, action: String){
        self.tableView = tableView
        
        self.refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        self.refreshControl.addTarget(target, action: Selector(action), forControlEvents: UIControlEvents.ValueChanged)
        
        tableView.addSubview(self.refreshControl)
    }
    
    func endRefreshing(){
        self.refreshControl.endRefreshing()
    }
}