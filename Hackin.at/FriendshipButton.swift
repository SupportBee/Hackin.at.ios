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
    var bordered: Bool = false
    
    var title: String {
        return ""
    }
    
    var disabledTitle: String {
        return ""
    }
    
    var requestSent = false
    
    convenience init(toBeFriend: Hacker,
        bordered: Bool = false){
        self.init()
        self.toBeFriend = toBeFriend
        self.bordered = bordered
        setupStyling()
        renderButton()
        setupTargetAction()
        sizeToFit()
    }
    
    func setupStyling(){
        titleLabel!.font = UIFont(name: "streamline", size: 32.0)
        if(bordered){
            setTitleColor(AppColors.primaryButtonColor, forState: UIControlState.Normal)
        }else{
            setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        }
    }

    func renderButton(){
        setTitle(title, forState: UIControlState.Normal)
        setTitle(disabledTitle, forState: UIControlState.Disabled)
    }
    
    func setupTargetAction(){
       addTarget(self, action: "buttonPressed", forControlEvents: UIControlEvents.TouchUpInside)
    }
    
    func buttonPressed(){
        println("Implement in Subclass")
        
    }
   

}