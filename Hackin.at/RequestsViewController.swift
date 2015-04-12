//
//  RequestsViewController.swift
//  Hackin.at
//
//  Created by Prateek on 3/14/15.
//  Copyright (c) 2015 Prateek Dayal. All rights reserved.
//

import UIKit

class RequestsViewController: UIViewController{
    
    var requests: [FriendshipRequest] = []
    var requestsTable: HackersListingView!
    var toBeFriends: [Hacker] = []
    
    override func viewDidLoad() {
        setupRequestsTable()
    }
    
    func setupRequestsTable(){
        requestsTable = HackersListingView(cellStyle: HackerTableCell.FriendshipRequestView.self,
            pullToRefresh: false,
            emptyTableMessage: "No pending friendship requests.\n Time to hit a meetup?",
            hackersDataSource: MyPendingFriendsDataSource())
        view.addSubview(requestsTable)
     
    }
    
    override func updateViewConstraints() {
        requestsTable.autoPinEdgesToSuperviewEdgesWithInsets(UIEdgeInsetsZero)
        super.updateViewConstraints()
    }

}