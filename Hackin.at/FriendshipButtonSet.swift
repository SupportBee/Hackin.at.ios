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
        var setFrame = true
        if(button != nil){
            button.removeFromSuperview()
            setFrame = false
        }
        button = FriendshipButtonSet.appropriateButton(toBeFriend)
        if(setFrame) {self.frame = button.frame}
        self.addSubview(button)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func actionCompleted() {
        // Re-render the button
        // assumes that toBeFriend has been 
        // updated correctly
        renderButton()
    }
    
    override func updateConstraints() {
        // TODO: Hack since subclass may not have button
        // Ex: AcceptDenyFriendshipButtonSet
        if(button != nil){
            button.autoPinEdgesToSuperviewMargins()
        }
        super.updateConstraints()
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