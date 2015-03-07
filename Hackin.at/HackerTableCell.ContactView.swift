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
        
            nameLabel.autoPinEdgeToSuperviewEdge(ALEdge.Bottom, withInset: AppTheme.Listing.elementsPadding)

            super.updateConstraints()
        }
  
        
    }
    
}