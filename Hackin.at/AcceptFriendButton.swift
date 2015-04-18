//
//  AcceptFriendButton.swift
//  Hackin.at
//
//  Created by Prateek on 4/10/15.
//  Copyright (c) 2015 Prateek Dayal. All rights reserved.
//

import UIKit

class AcceptFriendButton: FriendshipButton {
    
    override var title: String {
        return "e"
    }
    
    override var disabledTitle: String {
        return "Accepting Friendship"
    }
    
    func buttonPressed(){
        if (requestSent == false){
            func success(){
                self.requestSent = true
                self.enabled = false
                toBeFriend.isFriends = true
                toBeFriend.friendRequest = nil
                delegate?.actionCompleted()
            }
            Hackinat.sharedInstance.acceptFriendshipRequest(toBeFriend.friendRequest!.id,
                success: success)
        }
    }


    
}