//
//  AddFriendButton.swift
//  Hackin.at
//
//  Created by Prateek on 4/10/15.
//  Copyright (c) 2015 Prateek Dayal. All rights reserved.
//

import UIKit

class AddFriendButton: FriendshipButton {
   
    override var title: String {
        return "c"
    }
    
    override var disabledTitle: String {
        return "Waiting to Accept"
    }
    
    
    override func buttonPressed(){
        if (requestSent == false){
            func success(friendRequest: FriendshipRequest){
                self.requestSent = true
                self.enabled = false
                toBeFriend.isFriends = false
                toBeFriend.friendRequest = friendRequest
                delegate?.actionCompleted()
            }
            CurrentHacker().sendFriendshipRequest(toBeFriend, onsuccess: success)
        }
    }

}