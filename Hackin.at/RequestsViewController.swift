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
        fetchMyFriendshipRequests()
    }
    
    func setupRequestsTable(){
        requestsTable = HackersListingView(cellStyle: HackerTableCell.FriendshipRequestView.self,
            pullToRefresh: false,
            emptyTableMessage: "No pending friendship requests.\n Time to hit a meetup?",
            hackersDataSource: HackersDataSource())
        view.addSubview(requestsTable)
     
    }
    
    func fetchMyFriendshipRequests(){
        
        func onFetch(requests: [FriendshipRequest]){
            self.requests = requests
            toBeFriends = requests.map({(request) -> Hacker in
//                request.sender.friendshipRequest = request
                return request.sender
            })
            renderRequests()
        }
        
        FriendshipRequest.all(onFetch)
    }
    
    func renderRequests(){
        requestsTable.renderHackers(toBeFriends)
    }

    override func updateViewConstraints() {
        requestsTable.autoPinEdgesToSuperviewEdgesWithInsets(UIEdgeInsetsZero)
        super.updateViewConstraints()
    }

}