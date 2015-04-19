//
//  SendFriendshipRequestButton.swift
//  Hackin.at
//
//  Created by Prateek on 3/13/15.
//  Copyright (c) 2015 Prateek Dayal. All rights reserved.
//

import UIKit
import PureLayout

class FriendshipButton: UIButton {
    
    var toBeFriend: Hacker!
    var delegate: FriendshipButtonDelegate?
    
    var title: String {
        return ""
    }
    
    var disabledTitle: String {
        return ""
    }
    
    var requestSent = false
    
    convenience init(toBeFriend: Hacker){
        self.init()
        self.titleLabel!.font = UIFont(name: "streamline", size: 32.0)
        self.toBeFriend = toBeFriend
        renderButton()
        setupTargetAction()
        sizeToFit()
    }

    func renderButton(){
        setTitle(title, forState: UIControlState.Normal)
        setTitle(disabledTitle, forState: UIControlState.Disabled)
        setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
    }
    
    func setupTargetAction(){
       addTarget(self, action: "buttonPressed", forControlEvents: UIControlEvents.TouchUpInside)
    }
    
    func buttonPressed(){
        println("Implement in Subclass")
        
    }
   

}