//
//  BroadcastTableViewCell.swift
//  Hackin.at
//
//  Created by Prateek on 12/26/14.
//  Copyright (c) 2014 Prateek Dayal. All rights reserved.
//

import UIKit

class BroadcastTableViewCell: UITableViewCell {
    
    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet weak var whereLabel: UILabel!
    @IBOutlet weak var messageText: UITextView!
    @IBOutlet weak var loginLabel: UILabel!
    @IBOutlet weak var whenLabel: UILabel!
    
    override func awakeFromNib() {
        
        // Circular image
        self.profileImageView.layer.cornerRadius = self.profileImageView.frame.size.width/2;
        self.profileImageView.clipsToBounds = true;
        
        self.messageText.scrollEnabled = false
        self.messageText.backgroundColor = AppColors.textBackground
        
        // No inset for cell border
        // http://stackoverflow.com/questions/25770119/ios-8-uitableview-separator-inset-0-not-working
        self.preservesSuperviewLayoutMargins = false
        self.layoutMargins = UIEdgeInsetsZero
        
    }

    override func updateConstraints(){
        let kLabelHorizontalInsets: CGFloat = 15.0
        
        self.profileImageView.autoPinEdgeToSuperviewEdge(ALEdge.Left, withInset: kLabelHorizontalInsets)
        self.profileImageView.autoPinEdgeToSuperviewEdge(ALEdge.Top, withInset: kLabelHorizontalInsets)
        
        self.messageText.autoPinEdge(ALEdge.Top, toEdge: ALEdge.Bottom, ofView: self.profileImageView, withOffset: kLabelHorizontalInsets)
        
        self.messageText.autoMatchDimension( ALDimension.Width, toDimension: ALDimension.Width, ofView: self.contentView, withOffset: 0)

        self.whereLabel.autoPinEdge(ALEdge.Top, toEdge: ALEdge.Bottom, ofView: self.messageText, withOffset: kLabelHorizontalInsets)
        self.whereLabel.autoPinEdgeToSuperviewEdge(ALEdge.Bottom, withInset: kLabelHorizontalInsets)
        self.whereLabel.autoPinEdgeToSuperviewEdge(ALEdge.Right, withInset: kLabelHorizontalInsets)
        
        super.updateConstraints()
    }
}
