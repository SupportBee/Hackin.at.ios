//
//  AcceptDenyFriendshipButtonSet.swift
//  Hackin.at
//
//  Created by Prateek on 4/11/15.
//  Copyright (c) 2015 Prateek Dayal. All rights reserved.
//

import UIKit
import PureLayout

class AcceptDenyFriendshipButtonSet: FriendshipButtonSet {
    
    var acceptButton: FriendshipButton!
    var denyButton: FriendshipButton!
    
    override func renderButton() {
        // Two buttons!
        acceptButton = AcceptFriendButton(toBeFriend: toBeFriend)
        denyButton = DenyFriendRequest(toBeFriend: toBeFriend)
        self.addSubview(acceptButton)
        self.addSubview(denyButton)
    }
    
    override func updateConstraints() {
        acceptButton.autoPinEdgeToSuperviewEdge(ALEdge.Left)
        acceptButton.autoPinEdgeToSuperviewEdge(ALEdge.Top)
        acceptButton.autoPinEdgeToSuperviewEdge(ALEdge.Bottom)
        
        denyButton.autoPinEdge(ALEdge.Left, toEdge: ALEdge.Right, ofView: acceptButton, withOffset: AppTheme.Listing.elementsPadding)
        denyButton.autoPinEdgeToSuperviewEdge(ALEdge.Top)
        denyButton.autoPinEdgeToSuperviewEdge(ALEdge.Right)
        denyButton.autoPinEdgeToSuperviewEdge(ALEdge.Bottom)
        
        super.updateConstraints()
    }
    
}