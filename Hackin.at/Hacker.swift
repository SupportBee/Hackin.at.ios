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
    
    let stickerMap = [
        "1": "\u{E097}",
        "2": "\u{E091}",
        "3": "\u{E098}",
        "4": "\u{E090}",
        "5": "\u{E09A}",
        "6": "\u{E086}",
        "7": "\u{E001}",
        "8": "\u{E09E}",
        "9": "\u{E003}",
        "10": "\u{E08D}",
        "11": "\u{E08D}",
        "12": "\u{E08D}",
        "13": "\u{E093}",
        "14": "\u{E096}",
        "15": "\u{E092}",
        "16": "\u{E0B4}",
        "17": "\u{E0B3}",
        "18": "\u{E0B6}",
        "19": "\u{E0B8}",
        "20": "\u{E0A0}",
        "21": "\u{E08B}",
        "22": "\u{E061}",
        "23": "\u{E08C}",
        "24": "\u{E08A}",
        "25": "\u{E0B7}"
    ]
    
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
    
    func stickerCodes() -> String{
        let stickersJSON:JSON = userDetails!["stickers"]
        
        var unicodeString = ""
        for (index: String, subJson: JSON) in stickersJSON {
            var unicode = stickerMap[subJson["id"].stringValue]!
            unicodeString = "\(unicodeString) \(unicode)"
        }
        return unicodeString
    }
    
    private func setUserDetails(userJSON:AnyObject!){
        self.userDetails = JSON(userJSON)["hacker"]
    }

}