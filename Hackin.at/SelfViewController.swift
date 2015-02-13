//
//  SelfViewController.swift
//  Hackin.at
//
//  Created by Prateek on 2/10/15.
//  Copyright (c) 2015 Prateek Dayal. All rights reserved.
//


import UIKit
import PureLayout

class SelfViewController: UIViewController{
    
    override func viewDidLoad() {
        self.edgesForExtendedLayout = UIRectEdge.None
        self.title = "Self"
        var hackersStoryboard = UIStoryboard(name: "Hackers", bundle: nil);
        let vc = hackersStoryboard.instantiateViewControllerWithIdentifier("profileViewController") as ProfileViewController;
        self.view.addSubview(vc.view)
    }

}