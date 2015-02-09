//
//  HackerTableViewCell.swift
//  Hackin.at
//
//  Created by Avinasha Shastry on 06/02/15.
//  Copyright (c) 2015 Prateek Dayal. All rights reserved.
//

import UIKit
import PureLayout

class HackerTableViewCell: UITableViewCell {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var loginLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var stickersLabel: UILabel!
    @IBOutlet weak var whereLabel: UILabel!
    
    override func awakeFromNib() {
        // Circular image
        self.profileImageView.layer.cornerRadius = self.profileImageView.frame.size.width/2;
        self.profileImageView.clipsToBounds = true;
        
        self.loginLabel.textColor = AppColors.primaryLabel
        self.nameLabel.textColor = AppColors.secondaryLabel
        
        // No inset for cell border
        // http://stackoverflow.com/questions/25770119/ios-8-uitableview-separator-inset-0-not-working
        self.preservesSuperviewLayoutMargins = false
        self.layoutMargins = UIEdgeInsetsZero
    }
    
    override func updateConstraints(){
        
        profileImageView.autoPinEdgeToSuperviewEdge(ALEdge.Left,
            withInset: AppTheme.HackerListing.paddingLeft)
        profileImageView.autoPinEdgeToSuperviewEdge(ALEdge.Top,
            withInset: AppTheme.HackerListing.paddingTop)
        
        loginLabel.autoPinEdge(ALEdge.Left, toEdge: ALEdge.Right, ofView: profileImageView,
            withOffset: AppTheme.Listing.elementsPadding)
        loginLabel.autoPinEdgeToSuperviewEdge(ALEdge.Top,
            withInset: AppTheme.HackerListing.paddingTop)
        
        
        nameLabel.autoPinEdge(ALEdge.Left, toEdge: ALEdge.Right, ofView: profileImageView, withOffset: AppTheme.Listing.elementsPadding)
        nameLabel.autoPinEdge(ALEdge.Top, toEdge: ALEdge.Bottom, ofView: loginLabel, withOffset: AppTheme.Listing.elementsPadding)

        stickersLabel.autoPinEdge(ALEdge.Left, toEdge: ALEdge.Right, ofView: profileImageView, withOffset: AppTheme.Listing.elementsPadding)
        stickersLabel.autoPinEdge(ALEdge.Top, toEdge: ALEdge.Bottom, ofView: nameLabel, withOffset: AppTheme.Listing.elementsPadding)

        whereLabel.autoPinEdgeToSuperviewEdge(ALEdge.Right, withInset: AppTheme.HackerListing.paddingRight)
        whereLabel.autoPinEdge(ALEdge.Top, toEdge: ALEdge.Bottom, ofView: stickersLabel, withOffset: AppTheme.Listing.elementsPadding)
        whereLabel.autoPinEdgeToSuperviewEdge(ALEdge.Bottom, withInset: AppTheme.HackerListing.paddingRight)

        super.updateConstraints()

        
    }

}
