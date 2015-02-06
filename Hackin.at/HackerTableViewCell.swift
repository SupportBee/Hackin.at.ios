//
//  HackerTableViewCell.swift
//  Hackin.at
//
//  Created by Avinasha Shastry on 06/02/15.
//  Copyright (c) 2015 Prateek Dayal. All rights reserved.
//

import UIKit

class HackerTableViewCell: UITableViewCell {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var loginLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var stickersLabel: UILabel!
    @IBOutlet weak var whereLabel: UILabel!
    
    let kLabelHorizontalInsets: CGFloat = 10.0
    
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

}
