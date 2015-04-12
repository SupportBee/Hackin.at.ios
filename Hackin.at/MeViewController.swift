//
//  SelfViewController.swift
//  Hackin.at
//
//  Created by Prateek on 2/10/15.
//  Copyright (c) 2015 Prateek Dayal. All rights reserved.
//


import UIKit
import PureLayout

class MeViewController: UINavigationController{
    
    override func viewDidLoad() {
        let vc = AppScreens.Profile(CurrentHacker.hacker()!).vc
        setViewControllers([vc], animated: false)
    }

}