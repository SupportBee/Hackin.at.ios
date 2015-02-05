//
//  Hacker.swift
//  Hackin.at
//
//  Created by Avinasha Shastry on 02/02/15.
//  Copyright (c) 2015 Prateek Dayal. All rights reserved.
//

import SwiftyJSON
import Alamofire

class Hacker: NSObject {
    var authKey:String?
    var userDetails:JSON?
    var avatarImage:UIImage?
    
    let login:String
    
    init(login: String) {
        self.login = login
    }
    
    convenience init(login: String, authKey: String){
        self.init(login: login)
        self.authKey = authKey
    }
    
    var avatarURL:String?{
        if(userDetails == nil){
            return nil
        }
        return userDetails!["avatar_url"].stringValue
    }
    
    convenience init(json: JSON){
        self.init(login: json["login"].stringValue)
        self.userDetails = json
    }
    
    func fetchAvatarImage(#success: (UIImage) -> ()){
        if(avatarImage != nil){ success(avatarImage!) }
        if(avatarURL != nil){
            Alamofire.request(.GET, avatarURL!)
                .response{ (_, _, data, _) in
                    self.avatarImage = UIImage(data: (data as NSData))
                    if(self.avatarImage != nil){
                        success(self.avatarImage!)
                    }
            }
        }
    }
    
    func fetchFullProfile(#success: () -> ()){
        
        func onFetch(json: AnyObject!){
            setUserDetails(json)
            success()
        }
        
        if authKey == nil {
            Hackinat.sharedInstance.getHacker(login: login, success: onFetch)
        }else{
            Hackinat.sharedInstance.getHacker(login: login, authKey: authKey!, success: onFetch)
        }
    }

    func checkTwitterAccess(#success: (Int) -> ()){
        if(authKey != nil){
            func onFetch(){
                success(self.userDetails!["twitter_enabled"].int!)
            }
        
            fetchFullProfile(success: onFetch)
        }
    }
    
    func updateTwitterCredentials(#authToken:String, authSecret: String, success: () -> (), failure: () -> () = {}){
        
        func onUpdate(){
            success()
        }

        func onFailure(){
            failure()
        }

        Hackinat.sharedInstance.updateHackerTwitterCredentials(login: login, authKey: authKey!, authToken: authToken, authSecret: authSecret, success: onUpdate, failure: onFailure)
    }
    
    private func setUserDetails(userJSON:AnyObject!){
        self.userDetails = JSON(userJSON)["hacker"]
    }

}