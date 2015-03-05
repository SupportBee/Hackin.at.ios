//
//  AppTheme.swift
//  Hackin.at
//
//  Created by Prateek on 2/8/15.
//  Copyright (c) 2015 Prateek Dayal. All rights reserved.
//

public struct AppTheme {
    struct Listing {
        static let elementsPadding: CGFloat = 15.0
    };
    
    struct HackerListing {
        static let profileImageSize = 40;
        static let paddingLeft: CGFloat = 20.0;
        static let paddingRight: CGFloat = 20.0;
        static let paddingTop: CGFloat = 15.0;
    };
    
    struct HackerSummary {
        static let imageSize: CGFloat = 36.0;
        static let imageLoginSpace: CGFloat = 15.0;
    }
    
    struct IconLabel {
        static let paddingRight: CGFloat = 5.0;
    }
}

public func setupAppStyling(){
    
    // Navigation Bar
    UINavigationBar.appearance().barTintColor = AppColors.barTint
    UINavigationBar.appearance().translucent = false
    UINavigationBar.appearance().barStyle = UIBarStyle.Black
    UINavigationBar.appearance().tintColor = UIColor.whiteColor()

    UITabBar.appearance().tintColor = AppColors.barTint
    UITabBar.appearance().barTintColor = UIColor.whiteColor()
    
}