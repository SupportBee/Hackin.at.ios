//
//  UIIconLabel.swift
//  Hackin.at
//
//  Created by Prateek on 2/16/15.
//  Copyright (c) 2015 Prateek Dayal. All rights reserved.
//

import Foundation

import UIKit

class UIIconLabel: UILabel {
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init() {
        super.init()
        let font = UIFont(name: "streamline", size: 24)!
        self.font = font
    }
    
}