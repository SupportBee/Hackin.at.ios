//
//  HackerTableCell.FullView.swift
//  Hackin.at
//
//  Created by Prateek on 3/7/15.
//  Copyright (c) 2015 Prateek Dayal. All rights reserved.
//

import PureLayout

extension HackerTableCell {
    
    class FullView: HackerTableCell {
        
        let stickersLabel = UILabel()
        
        required init(style: UITableViewCellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            setupStickersLabel()
        }
        
        required init(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
        }
        
        func setupStickersLabel(){
            self.stickersLabel.font = UIFont(name: "pictonic", size: 16)
            contentView.addSubview(stickersLabel)
        }
        
        override func updateConstraints(){
            
            super.updateConstraints()
            
            stickersLabel.autoPinEdge(ALEdge.Left, toEdge: ALEdge.Right, ofView: profileImageView, withOffset: AppTheme.Listing.elementsPadding)
            stickersLabel.autoPinEdge(ALEdge.Top, toEdge: ALEdge.Bottom, ofView: nameLabel, withOffset: AppTheme.Listing.elementsPadding)
            stickersLabel.autoPinEdgeToSuperviewEdge(ALEdge.Bottom, withInset: AppTheme.Listing.elementsPadding, relation: NSLayoutRelation.GreaterThanOrEqual)
        }
        
        override func setupViewData(hacker: Hacker) {
            let stickers = hacker.stickerCodes()
            self.stickersLabel.text = stickers
            super.setupViewData(hacker)
        }
        
    }
    
    
}