//
//  HackerSummaryView.swift
//  Hackin.at
//
//  Created by Prateek on 2/13/15.
//  Copyright (c) 2015 Prateek Dayal. All rights reserved.
//

import UIKit
import PureLayout

class HackerSummaryView: UIView {
    
    var hacker:Hacker!
    var imageView:UIImageView!
    var loginLabelView:UILabel!
    
    required init(coder aDecoder: NSCoder) {
        imageView = UIImageView(frame: CGRectMake(0, 0, AppTheme.HackerSummary.imageSize, AppTheme.HackerSummary.imageSize))
        loginLabelView = UILabel()
        imageView.layer.cornerRadius = imageView.frame.size.width / 2;
        imageView.clipsToBounds = true;
        
        super.init(coder: aDecoder)
        
        addSubview(imageView)
        addSubview(loginLabelView)
    }
    
    func renderView(){
        loginLabelView.text = "@\(hacker.login)"
        loginLabelView.sizeToFit()
        backgroundColor = UIColor.whiteColor()
        
        hacker.fetchAvatarURL(size: AppTheme.HackerSummary.imageSize, success: {
            (url: String) in
            self.imageView.sd_setImageWithURL(NSURL(string: url))
        })
        
    }
    
    override func updateConstraints() {
        imageView.autoPinEdgeToSuperviewEdge(ALEdge.Left)
        imageView.autoPinEdgeToSuperviewEdge(ALEdge.Top)
        imageView.autoSetDimension(ALDimension.Width, toSize: AppTheme.HackerSummary.imageSize)
        imageView.autoSetDimension(ALDimension.Height, toSize: AppTheme.HackerSummary.imageSize)

        loginLabelView.autoPinEdge(ALEdge.Left, toEdge: ALEdge.Right, ofView: imageView, withOffset: AppTheme.HackerSummary.imageLoginSpace)
        loginLabelView.autoAlignAxis(ALAxis.Horizontal, toSameAxisOfView: imageView)

        super.updateConstraints()
    }
    
}