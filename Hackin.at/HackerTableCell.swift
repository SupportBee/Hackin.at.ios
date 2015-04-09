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
//        layoutMargins = UIEdgeInsetsZero
//        let point = self.convertPoint(imageView!.center, fromView: self)
        layoutMargins = UIEdgeInsetsMake(0, paddingLeft + profileImageSize + imageLabelSpacing, 0, 0)
   }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    var profileImageSize: CGFloat {
        get {
            return AppTheme.HackerContactView.profileImageSize
        }
    }
    
    var paddingLeft: CGFloat {
        get {
            return AppTheme.HackerContactView.paddingLeft
        }
    }
    
    var paddingTop: CGFloat {
        get {
            return AppTheme.HackerContactView.paddingTop
        }
    }
    
    var imageLabelSpacing: CGFloat {
        get {
            return AppTheme.HackerContactView.imageLabelSpacing
        }
    }
    
    func setupProfileImage(){
        profileImageView = UIImageView(frame: CGRectMake(0, 0, profileImageSize, profileImageSize))
        Helpers.roundImageView(profileImageView)
        contentView.addSubview(profileImageView)
    }

    func setupLoginLabel(){
        loginLabel = UILabel()
        loginLabel.textColor = AppTheme.HackerContactView.loginLabelColor
        contentView.addSubview(loginLabel)
    }

    func setupNameLabel(){
        nameLabel = UILabel()
        nameLabel.textColor = AppTheme.HackerContactView.nameLabelColor
        contentView.addSubview(nameLabel)
    }

    override func updateConstraints() {
        profileImageView.autoSetDimensionsToSize(CGSizeMake(profileImageSize, profileImageSize))
        profileImageView.autoPinEdgeToSuperviewEdge(ALEdge.Left,
            withInset: paddingLeft)
        profileImageView.autoPinEdgeToSuperviewEdge(ALEdge.Top,
            withInset: paddingTop)
        
        loginLabel.autoPinEdge(ALEdge.Left, toEdge: ALEdge.Right, ofView: profileImageView,
            withOffset: imageLabelSpacing)
        loginLabel.autoPinEdgeToSuperviewEdge(ALEdge.Top,
            withInset: AppTheme.HackerListing.paddingTop)
        
        nameLabel.autoPinEdge(ALEdge.Left, toEdge: ALEdge.Right, ofView: profileImageView, withOffset: AppTheme.HackerContactView.imageLabelSpacing)
        nameLabel.autoPinEdge(ALEdge.Top, toEdge: ALEdge.Bottom, ofView: loginLabel, withOffset: AppTheme.HackerContactView.loginNameSpacing)
        super.updateConstraints()
    }
   
    func setupViewData(hacker: Hacker){
        let login = hacker.login
        
        var name = ""
        if(hacker.name != nil){ name = hacker.name! }
        
        var locationName = ""
        
        loginLabel.text = "@\(login)"
        
        nameLabel.text = name

        let imageSize = CGFloat(48.0)
        
        Helpers.showProfileImage(hacker, imageView: profileImageView)
    }
}
