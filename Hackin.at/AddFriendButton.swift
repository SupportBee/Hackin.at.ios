//
//  AddFriendButton.swift
//  Hackin.at
//
//  Created by Prateek on 4/10/15.
//  Copyright (c) 2015 Prateek Dayal. All rights reserved.
//

import UIKit

class AddFriendButton: SendFriendshipRequestButton {
   
    override var title: String {
        return "Add Friend"
    }
    
    override var disabledTitle: String {
        return "Waiting to Accept"
    }
    
    
    override func setupTargetAction(){
       addTarget(self, action: "buttonPressed", forControlEvents: UIControlEvents.TouchUpInside)
    }
    
    func buttonPressed(){
        if (requestSent == false){
            func success(){
                self.requestSent = true
                self.enabled = false
            }
            CurrentHacker().sendFriendshipRequest(toBeFriend, onsuccess: success)
        }
    }

}