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
    
    convenience init(toBeFriend: Hacker){
        self.init()
        self.toBeFriend = toBeFriend
        renderButton()
        sizeToFit()
    }
    
    func renderButton(){
        setTitle("Add Friend", forState: UIControlState.Normal)
        setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
    }
    
}