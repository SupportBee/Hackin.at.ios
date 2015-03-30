//
//  AppScreens.swift
//  Hackin.at
//
//  Created by Prateek on 3/30/15.
//  Copyright (c) 2015 Prateek Dayal. All rights reserved.
//

enum AppScreens {
    
   case Profile(Hacker)
    
    var vc: UIViewController {
        
        switch self{
            
        case .Profile(let hacker):
            var hackersStoryboard = UIStoryboard(name: "Hackers", bundle: nil);
            let vc = hackersStoryboard.instantiateViewControllerWithIdentifier("profileViewController") as ProfileViewController
            vc.hacker = hacker
            return vc
        }
    }
    
    
}