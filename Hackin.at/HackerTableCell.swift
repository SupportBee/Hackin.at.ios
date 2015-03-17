//
//  HackerTableCell.swift
//  Hackin.at
//
//  Created by Avinasha Shastry on 06/02/15.
//  Copyright (c) 2015 Prateek Dayal. All rights reserved.
//

import UIKit
import PureLayout

class HackerTableCell: UITableViewCell {

    var profileImageView: UIImageView!
    var loginLabel: UILabel!
    var nameLabel: UILabel!
    
    // http://stackoverflow.com/questions/25049121/calling-an-initializer-having-only-the-class-name-in-swift
    required override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        // Circular image
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.setTranslatesAutoresizingMaskIntoConstraints(false)

        setupProfileImage()
        setupLoginLabel()
        setupNameLabel()
        //contentView.addSubview(stickersLabel)
        
        // http://stackoverflow.com/questions/15894415/where-to-create-autolayout-constraints-for-subclassed-uitableviewcell
        setNeedsUpdateConstraints()
        
        // No inset for cell border
        // http://stackoverflow.com/questions/25770119/ios-8-uitableview-separator-inset-0-not-working
        preservesSuperviewLayoutMargins = false
        layoutMargins = UIEdgeInsetsZero
   }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    func setupProfileImage(){
        profileImageView = UIImageView(frame: CGRectMake(0, 0, 48.0, 48.0))
        profileImageView.layer.cornerRadius = self.profileImageView.frame.size.width/2;
        profileImageView.clipsToBounds = true;
        contentView.addSubview(profileImageView)
    }

    func setupLoginLabel(){
        loginLabel = UILabel()
        loginLabel.textColor = AppColors.primaryLabel
        contentView.addSubview(loginLabel)
    }

    func setupNameLabel(){
        nameLabel = UILabel()
        nameLabel.textColor = AppColors.primaryLabel
        contentView.addSubview(nameLabel)
    }

    override func updateConstraints() {
        profileImageView.autoSetDimensionsToSize(CGSizeMake(48.0, 48.0))
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
        super.updateConstraints()
    }
   
    func setupViewData(hacker: Hacker){
        let login = hacker.login
        
        var name = ""
        if(hacker.name != nil){ name = hacker.name! }
        
        var locationName = ""
        
        self.loginLabel.text = "@\(login)"
        self.nameLabel.text = name

       
        let imageSize = CGFloat(48.0)
        
        hacker.fetchAvatarURL(size: imageSize, success: {
            (url: String) in
                self.profileImageView.sd_setImageWithURL(NSURL(string: url))
        })
    }
}
