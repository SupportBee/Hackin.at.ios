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
    
    var friendshipRequest: FriendshipRequest?
    
    let login:String
    
    init(login: String) {
        self.login = login
    }
    
    convenience init(login: String, authKey: String){
        self.init(login: login)
        self.authKey = authKey
    }

    convenience init(json: JSON){
        self.init(login: json["login"].stringValue)
        setUserDetailsFromJSON(json)
    }
   
    // Returns the base URL if size = 0.0
    func avatarURL(size: CGFloat = 0.0) -> String?{
        let intSize = Int(size)
        if(userDetails == nil){ return nil }
        let _url = userDetails!["avatar_url"].stringValue
        if(intSize == 0){ return _url }
        return "\(_url)&s=\(intSize)"
    }
    
    var externalIdentity:String?{
        return login
    }

    func fetchAvatarURL(size: CGFloat = 0.0, success: (String)->()){
        if(avatarURL(size: size) != nil){
            success(self.avatarURL(size: size)!)
        }else{
            func onFetch(){
                success(avatarURL(size: size)!)
            }

            fetchFullProfile(success: onFetch)
        }
    }
    
    var name:String?{
        if(userDetails == nil){ return nil }
        return userDetails!["name"].stringValue
    }
    
    var distance:String{
        let distance = userDetails!["distance"].floatValue
        if (distance > 1000){
            return "\(Int(distance/1000)) km"
        }else{
            return "\(Int(distance)) m"
        }
    }

    class func search(searchTerm: String, success: ([Hacker]) -> ()) -> [Hacker]? {
        
        func onFetch(result: AnyObject){
            var hackersJSON = JSON(result)["results"]["hackers"].arrayValue
            var hackers: Array<Hacker> = []
            
            hackers = hackersJSON.map({
                (hacker) -> Hacker in
                return Hacker(json: hacker)
            }) 
            success(hackers)
        }
        
        Hackinat.sharedInstance.searchHackers(searchTerm, success: onFetch)
        return []
    }
    
    
    func fetchAvatarImage(#success: (UIImage) -> ()){
        if(avatarImage != nil){ success(avatarImage!) }
        
        func fetchImage(){
            Alamofire.request(.GET, avatarURL()!)
                .response{ (_, _, data, _) in
                    self.avatarImage = UIImage(data: (data as NSData))
                    if(self.avatarImage != nil){
                        success(self.avatarImage!)
                    }
            }
        }
        
        if(avatarURL() != nil){ fetchImage() } else{ fetchFullProfile(success: fetchImage)}
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
            unicodeString = "\(unicode) \(unicodeString)"
        }
        return unicodeString
    }
    
    func hasFullProfile() -> Bool{
        if(userDetails == nil){ return false}
        return true
    }
    
    private func setUserDetails(userJSON:AnyObject!){
        setUserDetailsFromJSON(JSON(userJSON)["hacker"])
    }
    
    private func setUserDetailsFromJSON(json: JSON){
        self.userDetails = json
    }

}