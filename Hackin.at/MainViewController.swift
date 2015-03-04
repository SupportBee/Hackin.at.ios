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
    }
    
    func setupTabBarTitles(){
        let viewControllers = self.viewControllers as Array<UINavigationController>
        
        let friends = viewControllers[0]
        let me = viewControllers[1]
        
        me.title = "Me"
        me.tabBarItem.image = UIImage(named : "self")
        
        friends.title = "Friends"
        
        var hackersStoryboard = UIStoryboard(name: "Hackers", bundle: nil);
        let vc = hackersStoryboard.instantiateViewControllerWithIdentifier("profileViewController") as ProfileViewController;
        me.setViewControllers([vc], animated: false)
        
    }

}