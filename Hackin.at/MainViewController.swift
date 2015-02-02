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
        let home = viewControllers[0]
        let notifications = viewControllers[1]
        let me = viewControllers[2]
        
        home.title = "Broadcasts"
        notifications.title = "Hackers"
        me.title = "Me"
    }
}