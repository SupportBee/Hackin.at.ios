//
//  HackerFriendshipRequestView.swift
//  Hackin.at
//
//  Created by Prateek on 3/17/15.
//  Copyright (c) 2015 Prateek Dayal. All rights reserved.
//

import PureLayout


extension HackerTableCell {
    
    class FriendshipRequestView: FullView {
        
        let acceptButton = UIButton()
        let rejectButton = UIButton()
        var friendshipRequest: FriendshipRequest!
        
        required init(style: UITableViewCellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            setupButtons()
        }
        
        required init(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
        }
        
        func setupButtons(){
            acceptButton.setTitle("Accept", forState: UIControlState.Normal)
            acceptButton.backgroundColor = UIColor.greenColor()
            acceptButton.addTarget(self, action: "acceptRequest", forControlEvents: UIControlEvents.TouchUpInside)
            
            
            rejectButton.setTitle("Reject", forState: UIControlState.Normal)
            rejectButton.backgroundColor = UIColor.grayColor()
            rejectButton.addTarget(self, action: "rejectRequest", forControlEvents: UIControlEvents.TouchUpInside)
            
            contentView.addSubview(acceptButton)
            contentView.addSubview(rejectButton)
        }
        
        func acceptRequest(){
            
            func onSuccess(){
                println("Friendship Request Accepted")
                self.friendshipRequest.sender.friendshipRequest = nil
            }
            Hackinat.sharedInstance.acceptFriendshipRequest(friendshipRequest.id, success: onSuccess)
        }

        func rejectRequest(){
            func onSuccess(){
                println("Friendship Request Rejected")
                self.friendshipRequest.sender.friendshipRequest = nil
            }
            Hackinat.sharedInstance.rejectFriendshipRequest(friendshipRequest.id, success: onSuccess)
        }
        
        override func setupViewData(hacker: Hacker) {
            self.friendshipRequest = hacker.friendshipRequest!
            super.setupViewData(hacker)
        }
        
        override func updateConstraints(){
            
            super.updateConstraints()
            
            acceptButton.autoPinEdge(ALEdge.Left, toEdge: ALEdge.Right, ofView: profileImageView, withOffset: AppTheme.Listing.elementsPadding)
            acceptButton.autoPinEdge(ALEdge.Top, toEdge: ALEdge.Bottom, ofView: nameLabel, withOffset: AppTheme.Listing.elementsPadding)
            rejectButton.autoPinEdge(ALEdge.Left, toEdge: ALEdge.Right, ofView: acceptButton, withOffset: AppTheme.Listing.elementsPadding)
            rejectButton.autoPinEdge(ALEdge.Top, toEdge: ALEdge.Bottom, ofView: nameLabel, withOffset: AppTheme.Listing.elementsPadding)
            acceptButton.autoPinEdgeToSuperviewEdge(ALEdge.Bottom, withInset: AppTheme.Listing.elementsPadding)
        }

    }
}