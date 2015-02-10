//
//  BroadcastTableViewCell.swift
//  Hackin.at
//
//  Created by Prateek on 12/26/14.
//  Copyright (c) 2014 Prateek Dayal. All rights reserved.
//

import UIKit
import PureLayout

class BroadcastTableViewCell: UITableViewCell {
    
    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet weak var whereLabel: UILabel!
    @IBOutlet weak var messageText: UITextView!
    @IBOutlet weak var loginLabel: UILabel!
    @IBOutlet weak var whenLabel: UILabel!
    
    let kLabelHorizontalInsets: CGFloat = 10.0
    
    override func awakeFromNib() {
        
        // Circular image
        self.profileImageView.layer.cornerRadius = self.profileImageView.frame.size.width/2;
        self.profileImageView.clipsToBounds = true;
        
        self.messageText.scrollEnabled = false
        self.messageText.backgroundColor = AppColors.textBackground
        self.messageText.textContainerInset = UIEdgeInsets(top: kLabelHorizontalInsets, left: kLabelHorizontalInsets, bottom: kLabelHorizontalInsets, right: kLabelHorizontalInsets)
        self.messageText.textColor = AppColors.primaryText
        
        self.loginLabel.textColor = AppColors.primaryLabel
        self.whereLabel.textColor = AppColors.secondaryLabel
        
        // No inset for cell border
        // http://stackoverflow.com/questions/25770119/ios-8-uitableview-separator-inset-0-not-working
        self.preservesSuperviewLayoutMargins = false
        self.layoutMargins = UIEdgeInsetsZero
        
    }

    override func updateConstraints(){
        
        self.profileImageView.autoPinEdgeToSuperviewEdge(ALEdge.Left, withInset: kLabelHorizontalInsets)
        self.profileImageView.autoPinEdgeToSuperviewEdge(ALEdge.Top, withInset: kLabelHorizontalInsets)
        
        self.loginLabel.autoPinEdge(ALEdge.Left, toEdge: ALEdge.Right, ofView: profileImageView, withOffset: kLabelHorizontalInsets)
        self.loginLabel.autoAlignAxis(ALAxis.Horizontal, toSameAxisOfView: profileImageView, withOffset: 0)
        
        self.messageText.autoPinEdge(ALEdge.Top, toEdge: ALEdge.Bottom, ofView: self.profileImageView, withOffset: kLabelHorizontalInsets)
        
        self.messageText.autoMatchDimension( ALDimension.Width, toDimension: ALDimension.Width, ofView: self.contentView, withOffset: 0)

        self.whereLabel.autoPinEdge(ALEdge.Top, toEdge: ALEdge.Bottom, ofView: self.messageText, withOffset: kLabelHorizontalInsets)
        self.whereLabel.autoPinEdgeToSuperviewEdge(ALEdge.Bottom, withInset: kLabelHorizontalInsets)
        self.whereLabel.autoPinEdgeToSuperviewEdge(ALEdge.Right, withInset: kLabelHorizontalInsets)
        
        super.updateConstraints()
    }
    
    func setData(broadcast:Broadcast){
        let hacker = broadcast.hacker
        let message = broadcast.message
        
        var placeName:String = ""
        if broadcast.place != nil{
            placeName = broadcast.place!.name
        }
        
        self.loginLabel.text = hacker.login
        self.messageText.text = message
        self.whereLabel.text = placeName
        hacker.fetchAvatarImage(success: {
            (image: UIImage) in
            self.profileImageView.image = image
        })
    }
}
