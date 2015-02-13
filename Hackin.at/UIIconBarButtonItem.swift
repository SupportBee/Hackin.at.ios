//
//  UIIconBarButtonItem.swift
//  Hackin.at
//
//  Created by Prateek on 2/13/15.
//  Copyright (c) 2015 Prateek Dayal. All rights reserved.
//

import UIKit

class UIIconBarButtonItem: UIBarButtonItem {
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init() {
        super.init()
    }
    
    override init(title: String?, style: UIBarButtonItemStyle, target: AnyObject?, action: Selector) {
        super.init(title: title, style: style, target: target, action: action)
        let font = UIFont(name: "streamline", size: 24)!
        self.setTitleTextAttributes([NSFontAttributeName: font], forState: UIControlState.Normal)
    }
}