//
//  AcceptDenyFriendshipButtonSet.swift
//  Hackin.at
//
//  Created by Prateek on 4/11/15.
//  Copyright (c) 2015 Prateek Dayal. All rights reserved.
//

import UIKit
import PureLayout

class RequestCompletedHandler: FriendshipButtonDelegate {
    
    var message: String!
    var callback: (String) -> ()
    
    init(message: String, callback: (String) -> ()){
        self.message = message
        self.callback = callback
    }
    
    func actionCompleted() {
        callback(message)
    }
    
}

class AcceptDenyFriendshipButtonSet: FriendshipButtonSet {
    
    var acceptButton: FriendshipButton!
    var denyButton: FriendshipButton!
    var successLabel: UILabel!
    
    override func renderButton() {
        // Two buttons!
        acceptButton = AcceptFriendButton(toBeFriend: toBeFriend)
        acceptButton.delegate = RequestCompletedHandler(message: "Request accepted", callback: showSuccessMessage)
        
        denyButton = DenyFriendRequest(toBeFriend: toBeFriend)
        denyButton.delegate = RequestCompletedHandler(message: "Request denied", callback:  showSuccessMessage)
        self.addSubview(acceptButton)
        self.addSubview(denyButton)
    }
    
    func showSuccessMessage(message:String){
        successLabel = UILabel()
        successLabel.text = message
        acceptButton.removeFromSuperview()
        denyButton.removeFromSuperview()
        addSubview(successLabel)
        setNeedsUpdateConstraints()
    }
 
    
    override func updateConstraints() {
        
        if(successLabel != nil){
            successLabel.autoPinEdgesToSuperviewMargins()
        }else{
            acceptButton.autoPinEdgeToSuperviewEdge(ALEdge.Left)
            acceptButton.autoPinEdgeToSuperviewEdge(ALEdge.Top)
            acceptButton.autoPinEdgeToSuperviewEdge(ALEdge.Bottom)
            
            denyButton.autoPinEdge(ALEdge.Left, toEdge: ALEdge.Right, ofView: acceptButton, withOffset: AppTheme.Listing.elementsPadding)
            denyButton.autoPinEdgeToSuperviewEdge(ALEdge.Top)
            denyButton.autoPinEdgeToSuperviewEdge(ALEdge.Right)
            denyButton.autoPinEdgeToSuperviewEdge(ALEdge.Bottom)
        }
        
        super.updateConstraints()
    }
    
}