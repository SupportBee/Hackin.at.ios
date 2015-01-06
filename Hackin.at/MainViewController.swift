//
//  MainViewController.swift
//  Hackin.at
//
//  Created by Prateek on 12/23/14.
//  Copyright (c) 2014 Prateek Dayal. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let viewControllers = self.viewControllers as Array<UINavigationController>
        let vc1 = viewControllers[0]
        let vc2 = viewControllers[1]
        let vc3 = viewControllers[2]
        vc1.title = "Home"
        vc2.title = "Notifications"
        vc3.title = "Me"
    }
}