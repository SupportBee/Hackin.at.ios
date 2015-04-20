//
//  HackerFriendshipRequestView.swift
//  Hackin.at
//
//  Created by Prateek on 3/17/15.
//  Copyright (c) 2015 Prateek Dayal. All rights reserved.
//

import PureLayout

extension HackerTableCell {
    
    class FriendshipRequestView: ContactView {
        
        var buttonSet: FriendshipButtonSet!
        var buttonsContainer: UIView!
        var successLabel: UILabel!
        
        required init(style: UITableViewCellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            setupButtonsContainer()
        }
        
        required init(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
        }
        
        func setupButtonsContainer(){
            buttonsContainer = UIView(frame: CGRectZero)
            buttonsContainer.clipsToBounds = true
            contentView.addSubview(buttonsContainer)
        }
        
        func setupButtons(hacker: Hacker){
            buttonSet = AcceptDenyFriendshipButtonSet(toBeFriend: hacker)
            buttonsContainer.addSubview(buttonSet)
        }
        
        func showSuccessMessage(message:String){
            successLabel = UILabel()
            successLabel.text = message
            buttonsContainer.addSubview(successLabel)
            setNeedsUpdateConstraints()
        }
        
        func afterAcceptReject(){
        }
        
        override func setupViewData(hacker: Hacker) {
            setupButtons(hacker)
            super.setupViewData(hacker)
        }
        
        override func updateConstraints(){
            
            super.updateConstraints()

            buttonsContainer.autoPinEdge(ALEdge.Top, toEdge: ALEdge.Bottom, ofView: nameLabel, withOffset: AppTheme.Listing.elementsPadding)
            buttonsContainer.autoPinEdgeToSuperviewEdge(ALEdge.Bottom, withInset: AppTheme.Listing.elementsPadding)
            buttonsContainer.autoPinEdge(ALEdge.Left, toEdge: ALEdge.Right, ofView: profileImageView, withOffset: AppTheme.Listing.elementsPadding)
            buttonsContainer.autoPinEdgeToSuperviewEdge(ALEdge.Right)
            
            
            if(successLabel != nil){
                successLabel.autoPinEdgesToSuperviewMargins()
            }else{
                buttonSet.autoPinEdgesToSuperviewMargins()
            }
        }

    }
}