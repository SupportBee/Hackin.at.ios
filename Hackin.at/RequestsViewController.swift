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
        requestsTable.registerClass(UITableViewCell.self, forCellReuseIdentifier: "RequestCell")
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
        let cell = requestsTable.dequeueReusableCellWithIdentifier("RequestCell") as UITableViewCell
        let hacker = self.requests[indexPath.row].sender
        cell.textLabel?.text  = "@\(hacker.login)"
        
        hacker.fetchAvatarURL(size: CGFloat(48.0), success: {
            (url: String) in
            cell.imageView!.sd_setImageWithURL(NSURL(string: url), placeholderImage: UIImage(named: "logo_square.png"))
        })
        
        
        cell.accessoryView = SendFriendshipRequestButton(toBeFriend: hacker)
        return cell;
    }
}
