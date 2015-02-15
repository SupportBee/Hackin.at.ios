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
        imageView = UIImageView(frame: CGRectMake(0, 0, 36.0, 36.0))
        loginLabelView = UILabel()
        
        super.init(coder: aDecoder)
        
        addSubview(imageView)
        addSubview(loginLabelView)
    }
    
    func renderView(){
        loginLabelView.text = "@\(hacker.login)"
        loginLabelView.sizeToFit()
        hacker.fetchAvatarImage(success: {
           (image: UIImage) in
            println(image)
            self.imageView.image = image
        })
        
    }
    
    override func updateConstraints() {
        imageView.autoPinEdgeToSuperviewEdge(ALEdge.Right)
        imageView.autoPinEdgeToSuperviewEdge(ALEdge.Top)
        super.updateConstraints()
    }
    
}