//
//  Helpers.swift
//  Hackin.at
//
//  Created by Prateek on 3/19/15.
//  Copyright (c) 2015 Prateek Dayal. All rights reserved.
//

class Helpers {
    
    class func showProfileImage(hacker:Hacker, imageView: UIImageView, size:CGFloat = 48.0){
        hacker.fetchAvatarURL(size: size, success: {
            (url: String) in
            imageView.sd_setImageWithURL(NSURL(string: url), placeholderImage: UIImage(named: "logo_square.png"))
        })
    }
    
    class func roundImageView(imageView: UIImageView){
        imageView.layer.cornerRadius = imageView.frame.size.width/2;
        imageView.clipsToBounds = true;
        imageView.layer.masksToBounds = true;
    }
    
    class Transformers {
        class func userInfoToPushData(userInfo: [NSObject: AnyObject]) -> PushNotificationData? {
            let userStr = PushNotificationManager.pushManager().getCustomPushData(userInfo)
            if( userStr == nil ){ return nil }
            
            let userData = userStr.dataUsingEncoding(NSASCIIStringEncoding, allowLossyConversion: false)
            var userLocalError: NSError?
            var userJSON: AnyObject! = NSJSONSerialization.JSONObjectWithData(userData!, options: NSJSONReadingOptions.MutableContainers, error: &userLocalError)
            
            var pushNotification: PushNotificationData
            
            var login: String?
            var type: String?
            var actor: Hacker? = nil
            
            
            if let dict = userJSON as? [String: AnyObject]{
                login = dict["login"] as! String?
                type = dict["type"] as! String?
                
                if let actorDict = dict["actor"] as? [String: AnyObject] {
                    var actorLogin = actorDict["login"] as! String?
                    actor = Hacker(login: actorLogin!)
                }
            }
            
            if(login == nil || type == nil){ return nil }
            
            return PushNotificationData(login: login!, type: type!, actor: actor, friendRequestID: nil)
        }
    }
    
    
}