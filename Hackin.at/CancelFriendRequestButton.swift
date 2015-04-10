//
//  CancelFriendRequest.swift
//  Hackin.at
//
//  Created by Prateek on 4/10/15.
//  Copyright (c) 2015 Prateek Dayal. All rights reserved.
//

import UIKit

class CancelFriendRequestButton: SendFriendshipRequestButton {
    
    override var title: String {
        return "Cancel Friendship"
    }
    
    override var disabledTitle: String {
        return "Canceling Friendship"
    }
    
}