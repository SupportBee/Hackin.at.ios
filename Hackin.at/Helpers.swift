//
//  Helpers.swift
//  Hackin.at
//
//  Created by Prateek on 3/19/15.
//  Copyright (c) 2015 Prateek Dayal. All rights reserved.
//

class Helpers {
    
    class func showProfileImage(hacker:Hacker, imageView: UIImageView){
        hacker.fetchAvatarURL(size: CGFloat(48.0), success: {
            (url: String) in
            imageView.sd_setImageWithURL(NSURL(string: url), placeholderImage: UIImage(named: "logo_square.png"))
        })
    }
}