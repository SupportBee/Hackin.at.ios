//
//  FriendshipRequest.swift
//  Hackin.at
//
//  Created by Prateek on 3/14/15.
//  Copyright (c) 2015 Prateek Dayal. All rights reserved.
//

class FriendshipRequest:NSObject {
    
    class func all(onFetch: ([FriendshipRequest]) -> ()){
        Hackinat.sharedInstance.fetchFriendshipRequests(onFetch)
    }
    
}

