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
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var loginLabel: UILabel!
    
    override func updateConstraints(){
      let kLabelHorizontalInsets: CGFloat = 15.0
      println("print constraints \(self.profileImageView.constraints())")
      self.profileImageView.autoCenterInSuperview()
      super.updateConstraints()
    }
}
