//
//  RequestsViewController.swift
//  Hackin.at
//
//  Created by Prateek on 3/14/15.
//  Copyright (c) 2015 Prateek Dayal. All rights reserved.
//

import UIKit

class RequestsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var requests: [FriendshipRequest] = []
    var requestsTable: UITableView!
    
    override func viewDidLoad() {
        setupRequestsTable()
        fetchMyFriendshipRequests()
    }
    
    func setupRequestsTable(){
        self.requestsTable = UITableView()
        requestsTable.dataSource = self
        requestsTable.delegate = self
        requestsTable.registerClass(HackerTableCell.FullView.self, forCellReuseIdentifier: "RequestCell")
        view.addSubview(requestsTable)
     
    }
    
    func fetchMyFriendshipRequests(){
        
        func onFetch(requests: [FriendshipRequest]){
            self.requests = requests
            renderRequests()
        }
        
        FriendshipRequest.all(onFetch)
    }
    
    func renderRequests(){
        println("render requests")
       requestsTable.reloadData()
    }

    override func updateViewConstraints() {
        requestsTable.autoPinEdgesToSuperviewEdgesWithInsets(UIEdgeInsetsZero)
        super.updateViewConstraints()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        println("render requests \(requests.count)")
        return requests.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = requestsTable.dequeueReusableCellWithIdentifier("RequestCell") as HackerTableCell.FullView
        let hacker = self.requests[indexPath.row].sender
        cell.setupViewData(hacker)
        return cell;
    }
}
