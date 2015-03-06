//
//  HackerTableCell.ContactView.swift
//  Hackin.at
//
//  Created by Prateek on 3/6/15.
//  Copyright (c) 2015 Prateek Dayal. All rights reserved.
//

import PureLayout

extension HackerTableCell {

    class ContactView: HackerTableCell {
        
        required init(style: UITableViewCellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
        }
        
        required init(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
        }
        
        override func updateConstraints(){
        
            nameLabel.autoPinEdge(ALEdge.Top, toEdge: ALEdge.Bottom, ofView: loginLabel, withOffset: AppTheme.Listing.elementsPadding, relation: NSLayoutRelation.GreaterThanOrEqual)

    //        stickersLabel.autoPinEdge(ALEdge.Left, toEdge: ALEdge.Right, ofView: profileImageView, withOffset: AppTheme.Listing.elementsPadding)
    //        stickersLabel.autoPinEdge(ALEdge.Top, toEdge: ALEdge.Bottom, ofView: nameLabel, withOffset: AppTheme.Listing.elementsPadding)

            super.updateConstraints()
        }
  
        
    }
    
}