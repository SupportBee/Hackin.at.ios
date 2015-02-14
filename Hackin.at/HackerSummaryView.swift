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
    
    
    override init(frame: CGRect) {
        println("Init")
        super.init(frame: frame)
    }
    
    required init(coder aDecoder: NSCoder) {
        println("decoder Init")
        super.init(coder: aDecoder)
        imageView = UIImageView(frame: CGRectMake(0, 0, 36.0, 36.0))
        loginLabelView = UILabel()
        addSubview(imageView)
        addSubview(loginLabelView)
    }
    
    func renderView(){
        loginLabelView.text = "@prateekdayal"
        imageView.image = UIImage(named: "broadcast")
        
        //hacker.fetchAvatarImage(success: {
        //    (image: UIImage) in
        //    self.imageView.image = image
        //})
        
    }
    
    override func updateConstraints() {
        imageView.autoPinEdgeToSuperviewEdge(ALEdge.Right)
        imageView.autoPinEdgeToSuperviewEdge(ALEdge.Top)
    }
    
}