//
//  RequestsViewController.swift
//  Hackin.at
//
//  Created by Prateek on 3/14/15.
//  Copyright (c) 2015 Prateek Dayal. All rights reserved.
//

import UIKit
import PureLayout

class RequestsViewController: UIViewController{
    
    var requests: [FriendshipRequest] = []
    var requestsTable: HackersListingView!
    var toBeFriends: [Hacker] = []
    
    override func viewDidLoad() {
        title = "Friend Requests"
        setupRequestsTable()
    }
    
    func setupRequestsTable(){
        requestsTable = HackersListingView(cellStyle: HackerTableCell.FriendshipRequestView.self,
            pullToRefresh: true,
            emptyTableMessage: "No unattended friendship requests.\n Time to hit a meetup?",
            hackersDataSource: MyPendingFriendsDataSource())
        requestsTable.currentNavigationController = navigationController!
        view.addSubview(requestsTable)
     
    }
    
    override func updateViewConstraints() {
        requestsTable.autoPinEdgesToSuperviewEdgesWithInsets(UIEdgeInsetsZero)
        super.updateViewConstraints()
    }

}