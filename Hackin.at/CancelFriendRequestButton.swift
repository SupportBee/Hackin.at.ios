//
//  CancelFriendRequest.swift
//  Hackin.at
//
//  Created by Prateek on 4/10/15.
//  Copyright (c) 2015 Prateek Dayal. All rights reserved.
//

import UIKit

class CancelFriendRequestButton: FriendshipButton {
    
    override var title: String {
        return "Cancel Friendship"
    }
    
    override var disabledTitle: String {
        return "Canceling Friendship"
    }
    
    func buttonPressed(){
        if (requestSent == false){
            func success(){
                self.requestSent = true
                self.enabled = false
                toBeFriend.isFriends = false
                toBeFriend.friendRequest = nil
                delegate?.actionCompleted()
            }
            Hackinat.sharedInstance.deleteFriendshipRequest(toBeFriend.friendRequest!.id,
                success: success)
        }
    }
    
}