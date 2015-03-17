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
            rejectButton.setTitle("Reject", forState: UIControlState.Normal)
            rejectButton.backgroundColor = UIColor.grayColor()
            contentView.addSubview(acceptButton)
            contentView.addSubview(rejectButton)
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