//
//  DenyFriendRequest.swift
//  Hackin.at
//
//  Created by Prateek on 4/10/15.
//  Copyright (c) 2015 Prateek Dayal. All rights reserved.
//

import UIKit

class DenyFriendRequest: FriendshipButton {
    
    override var title: String {
        return "Deny Friendship"
    }
    
    override var disabledTitle: String {
        return "Denying Friendship"
    }
    
}