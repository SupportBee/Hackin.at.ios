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
        setupTabBarTitles()
        mainTabbar = self
    }
    
    func setupTabBarTitles(){
        let viewControllers = self.viewControllers as! Array<UINavigationController>
        
        let friends = viewControllers[0]
        let requests = viewControllers[1]
        let notifications = viewControllers[2]
        let me = viewControllers[3]
        
        friends.title = "Friends"
        friends.tabBarItem.image = UIImage(named: "friends")
        
        me.title = "Me"
        me.tabBarItem.image = UIImage(named : "me")
        
        requests.title = "Requests"
        requests.tabBarItem.image = UIImage(named : "requests")
        
        notifications.title = "Notifications"
        notifications.tabBarItem.image = UIImage(named : "notifications")
        
    }

}