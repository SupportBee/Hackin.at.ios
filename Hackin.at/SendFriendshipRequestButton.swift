//
//  SendFriendshipRequestButton.swift
//  Hackin.at
//
//  Created by Prateek on 3/13/15.
//  Copyright (c) 2015 Prateek Dayal. All rights reserved.
//

import UIKit

class SendFriendshipRequestButton: UIButton {
    
    var toBeFriend: Hacker!
    
    var requestSent = false
    
    convenience init(toBeFriend: Hacker){
        self.init()
        self.toBeFriend = toBeFriend
        renderButton()
        setupTargetAction()
        sizeToFit()
    }
    
    func renderButton(){
        println("Is Friend? \(toBeFriend.isFriends)")
        println("Friendship \(toBeFriend.friendshipRequest?)")
        setTitle("Add Friend", forState: UIControlState.Normal)
        setTitle("Waiting to Accept", forState: UIControlState.Disabled)
        setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
    }
    
    func setupTargetAction(){
       addTarget(self, action: "buttonPressed", forControlEvents: UIControlEvents.TouchUpInside)
    }
    
    func buttonPressed(){
        if (requestSent == false){
            func success(){
                self.requestSent = true
                self.enabled = false
            }
            CurrentHacker().sendFriendshipRequest(toBeFriend, success)
        }
    }
}