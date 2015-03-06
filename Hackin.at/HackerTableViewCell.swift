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

    let profileImageView = UIImageView()
    let loginLabel = UILabel()
    let nameLabel = UILabel()
    let stickersLabel = UILabel()
    let whereLabel = UILabel()
    let distanceLabel = UILabel()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        // Circular image
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(profileImageView)
        addSubview(loginLabel)
        addSubview(nameLabel)
        addSubview(stickersLabel)
        addSubview(whereLabel)
        addSubview(distanceLabel)
        
        // http://stackoverflow.com/questions/15894415/where-to-create-autolayout-constraints-for-subclassed-uitableviewcell
        setNeedsUpdateConstraints()
        
        profileImageView.layer.cornerRadius = self.profileImageView.frame.size.width/2;
        profileImageView.clipsToBounds = true;
        
        loginLabel.textColor = AppColors.primaryLabel
        nameLabel.textColor = AppColors.primaryLabel
        whereLabel.textColor = AppColors.primaryLabel
        distanceLabel.textColor = AppColors.secondaryLabel
        
        // No inset for cell border
        // http://stackoverflow.com/questions/25770119/ios-8-uitableview-separator-inset-0-not-working
        preservesSuperviewLayoutMargins = false
        layoutMargins = UIEdgeInsetsZero
   }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

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

        distanceLabel.autoPinEdgeToSuperviewEdge(ALEdge.Right,
            withInset: AppTheme.HackerListing.paddingLeft)
        distanceLabel.autoAlignAxis(ALAxis.Horizontal, toSameAxisOfView: loginLabel)
        
        nameLabel.autoPinEdge(ALEdge.Left, toEdge: ALEdge.Right, ofView: profileImageView, withOffset: AppTheme.Listing.elementsPadding)
        nameLabel.autoPinEdge(ALEdge.Top, toEdge: ALEdge.Bottom, ofView: loginLabel, withOffset: AppTheme.Listing.elementsPadding)

        stickersLabel.autoPinEdge(ALEdge.Left, toEdge: ALEdge.Right, ofView: profileImageView, withOffset: AppTheme.Listing.elementsPadding)
        stickersLabel.autoPinEdge(ALEdge.Top, toEdge: ALEdge.Bottom, ofView: nameLabel, withOffset: AppTheme.Listing.elementsPadding)

        whereLabel.autoPinEdge(ALEdge.Left, toEdge: ALEdge.Right, ofView: profileImageView, withOffset: AppTheme.Listing.elementsPadding)
        whereLabel.autoPinEdge(ALEdge.Top, toEdge: ALEdge.Bottom, ofView: stickersLabel, withOffset: AppTheme.Listing.elementsPadding)
        whereLabel.autoPinEdgeToSuperviewEdge(ALEdge.Bottom, withInset: AppTheme.HackerListing.paddingRight)

        println("Updating constraints")
        super.updateConstraints()

        
    }
    
    func setupViewData(hacker: Hacker){
        let login = hacker.login
        
        var name = ""
        if(hacker.name != nil){ name = hacker.name! }
        
        var locationName = ""
        
        self.loginLabel.text = "@\(login)"
        self.nameLabel.text = name
        self.whereLabel.text = locationName
        self.distanceLabel.text = hacker.distance

        let stickers = hacker.stickerCodes()
        self.stickersLabel.font = UIFont(name: "pictonic", size: 16)
        self.stickersLabel.text = stickers
       
        hacker.fetchAvatarURL({
            (url: String) in
                self.profileImageView.sd_setImageWithURL(NSURL(string: url))
        })
    }
}
