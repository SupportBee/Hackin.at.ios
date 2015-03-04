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
        let me = viewControllers[0]
        
        var hackersStoryboard = UIStoryboard(name: "Hackers", bundle: nil);
        let vc = hackersStoryboard.instantiateViewControllerWithIdentifier("profileViewController") as ProfileViewController;
        me.setViewControllers([vc], animated: false)
        
    }

}