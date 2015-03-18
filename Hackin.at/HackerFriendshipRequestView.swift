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
        var buttonsContainer: UIView!
        
        required init(style: UITableViewCellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            setupButtonsContainer()
            setupButtons()
        }
        
        required init(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
        }
        
        func setupButtonsContainer(){
            buttonsContainer = UIView()
            contentView.addSubview(buttonsContainer)
        }
        
        func setupButtons(){
            acceptButton.setTitle("Accept", forState: UIControlState.Normal)
            acceptButton.backgroundColor = UIColor.greenColor()
            acceptButton.addTarget(self, action: "acceptRequest", forControlEvents: UIControlEvents.TouchUpInside)
            
            
            rejectButton.setTitle("Reject", forState: UIControlState.Normal)
            rejectButton.backgroundColor = UIColor.grayColor()
            rejectButton.addTarget(self, action: "rejectRequest", forControlEvents: UIControlEvents.TouchUpInside)
            
            buttonsContainer.addSubview(acceptButton)
            buttonsContainer.addSubview(rejectButton)
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

            buttonsContainer.autoPinEdge(ALEdge.Top, toEdge: ALEdge.Bottom, ofView: nameLabel, withOffset: AppTheme.Listing.elementsPadding)
            buttonsContainer.autoPinEdgeToSuperviewEdge(ALEdge.Bottom, withInset: AppTheme.Listing.elementsPadding)
            buttonsContainer.autoPinEdge(ALEdge.Left, toEdge: ALEdge.Right, ofView: profileImageView, withOffset: AppTheme.Listing.elementsPadding)
            
            acceptButton.autoPinEdgeToSuperviewEdge(ALEdge.Left)
            acceptButton.autoPinEdgeToSuperviewEdge(ALEdge.Top)
            acceptButton.autoPinEdgeToSuperviewEdge(ALEdge.Bottom)
            
            rejectButton.autoPinEdge(ALEdge.Left, toEdge: ALEdge.Right, ofView: acceptButton, withOffset: AppTheme.Listing.elementsPadding)
            rejectButton.autoPinEdgeToSuperviewEdge(ALEdge.Top)
            rejectButton.autoPinEdgeToSuperviewEdge(ALEdge.Bottom)
        }

    }
}