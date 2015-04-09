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
    
    struct HackerContactView {
        static let profileImageSize:CGFloat = 48.0;
        static let paddingLeft:CGFloat = 10.0;
        static let paddingRight:CGFloat = 0.0;
        static let paddingTop:CGFloat = 10.0;
        static let paddingBottom:CGFloat = 10.0;
        static let imageLabelSpacing: CGFloat = 10.0
        static let loginNameSpacing: CGFloat = 10.0
        
        static let loginLabelColor = UIColor.blackColor()
        static let nameLabelColor = UIColor(red: 142/255.0, green: 142/255.0, blue: 147/255.0, alpha: 1)
        
    }
    
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
    
    UISearchBar.appearance().barTintColor = AppColors.searchBarColor
    UISearchBar.appearance().tintColor = AppColors.searchTextColor
    
}