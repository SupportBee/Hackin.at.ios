//
//  DeleteFriendship.swift
//  Hackin.at
//
//  Created by Prateek on 4/10/15.
//  Copyright (c) 2015 Prateek Dayal. All rights reserved.
//

import UIKit

class DeleteFriendshipButton: CancelFriendRequestButton {
    
    override var title: String {
        return "f"
    }
    
    override var disabledTitle: String {
        return "Waiting to Delete"
    }
    
    override func makeRequest(success: () -> ()){
        Hackinat.sharedInstance.deleteFriend(toBeFriend.login,
                success: success)
    }
    
}