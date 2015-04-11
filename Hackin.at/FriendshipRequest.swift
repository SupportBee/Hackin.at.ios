//
//  FriendshipRequest.swift
//  Hackin.at
//
//  Created by Prateek on 3/14/15.
//  Copyright (c) 2015 Prateek Dayal. All rights reserved.
//

import SwiftyJSON

class FriendshipRequest:NSObject {
    
    var sender: Hacker!
    var id: Int!
    
    class func all(onFetch: ([FriendshipRequest]) -> ()){
        Hackinat.sharedInstance.fetchFriendshipRequests(onFetch)
    }
    
    convenience init(json: JSON){
        self.init()
        setupObjectFromJSON(json)
    }
    
    func setupObjectFromJSON(json:JSON){
        self.id = json["id"].intValue
        self.sender = Hacker(json: json["sender"])
    }
    
}

