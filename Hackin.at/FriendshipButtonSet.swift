//
//  FriendshipButtonSet.swift
//  Hackin.at
//
//  Created by Prateek on 4/11/15.
//  Copyright (c) 2015 Prateek Dayal. All rights reserved.
//

import UIKit

protocol FriendshipButtonDelegate {
    
    func actionCompleted()
    
}

class FriendshipButtonSet: UIView, FriendshipButtonDelegate {
    
    var toBeFriend: Hacker!
    var button: FriendshipButton!
    
    init(toBeFriend: Hacker){
        super.init(frame: CGRectZero)
        self.toBeFriend = toBeFriend
        renderButton()
    }
    
    func renderButton(){
        button = FriendshipButtonSet.appropriateButton(toBeFriend)
        self.frame = button.frame
        button.delegate = self
        self.addSubview(button)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func actionCompleted() {
        
    }
    
    override func updateConstraints() {
        button.autoPinEdgesToSuperviewMargins()
    }
    
    class func appropriateButton(toBeFriend: Hacker) -> FriendshipButton {
        if (toBeFriend.isFriends){
            return DeleteFriendshipButton(toBeFriend: toBeFriend)
        }else{
            if let friendRequest = toBeFriend.friendRequest{
                if (friendRequest.sender.login == CurrentHacker.hacker()!.login) {
                    let button = CancelFriendRequestButton(toBeFriend: toBeFriend)
                    return button
                }else{
                    return AcceptFriendButton(toBeFriend: toBeFriend)
                }
            }else{
                return AddFriendButton(toBeFriend: toBeFriend)
            }
        }
    }
}