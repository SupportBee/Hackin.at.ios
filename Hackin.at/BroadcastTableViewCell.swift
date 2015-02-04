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
        
        // Align the login and Image elements
        
        
    }
    
    override func updateConstraints(){
      let kLabelHorizontalInsets: CGFloat = 15.0
      println("print constraints \(self.profileImageView.constraints())")
      self.profileImageView.autoCenterInSuperview()
      super.updateConstraints()
    }
}
