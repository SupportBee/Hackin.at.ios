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
    
    var title: String {
        return ""
    }
    
    var disabledTitle: String {
        return ""
    }
    
    var requestSent = false
    
    convenience init(toBeFriend: Hacker){
        self.init()
        self.toBeFriend = toBeFriend
        renderButton()
        setupTargetAction()
        sizeToFit()
    }
    
    func renderButton(){
        setTitle(title, forState: UIControlState.Normal)
        setTitle(disabledTitle, forState: UIControlState.Disabled)
    }
    
    func setupTargetAction(){
        // Override
    }
   
}