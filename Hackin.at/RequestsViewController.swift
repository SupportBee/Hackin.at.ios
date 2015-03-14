//
//  RequestsViewController.swift
//  Hackin.at
//
//  Created by Prateek on 3/14/15.
//  Copyright (c) 2015 Prateek Dayal. All rights reserved.
//

import UIKit

class RequestsViewController: UIViewController {
    
    override func viewDidLoad() {
        fetchMyFriendshipRequests()
    }
    
    func fetchMyFriendshipRequests(){
        
        func onFetch(requests: [FriendshipRequest]){
            println("Found \(requests.count) requests")
        }
        
        FriendshipRequest.all(onFetch)
    }
}
