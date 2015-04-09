//
//  CurrentHacker.swift
//  Hackin.at
//
//  Created by Avinasha Shastry on 03/02/15.
//  Copyright (c) 2015 Prateek Dayal. All rights reserved.
//

import Locksmith
import SwiftyJSON

class CurrentHacker:NSObject {
    
    class var userAccount:String{
        return "HackinAt"
    }
    
    private struct CurrentHackerStruct{ static var hacker:Hacker = Hacker(login: "") }
    
    class var login:String?{
        get{
            return NSUserDefaults.standardUserDefaults().objectForKey("login") as? String
        }
        
        set{
            NSUserDefaults.standardUserDefaults().setObject(newValue!, forKey: "login")
        }
    }
    
    class var authKey:String?{
        get{
            if(login != nil){
                let (dictionary, error) = Locksmith.loadDataForUserAccount(userAccount)
                if(dictionary == nil){
                    return nil
                }else{
                    return dictionary!.objectForKey("auth_key") as! String?
                }
            }else{
                return nil
            }
        }
        
        set{
            Locksmith.deleteDataForUserAccount(userAccount)
            Locksmith.saveData(["auth_key": newValue!], forUserAccount: userAccount)
        }
    }
    
    class var apnsDeviceToken: String?{
        get{
            if (hacker() == nil){ return nil }
            return hacker()?.deviceToken
        }
        
        set{
            if (hacker() != nil){
                hacker()?.deviceToken = newValue!
            }
        }
    }
    
    class var twitterEnabled:Int?{
        get{
            return NSUserDefaults.standardUserDefaults().objectForKey("twitter_enabled") as? Int
        }
        
        set{
            NSUserDefaults.standardUserDefaults().setObject(newValue!, forKey: "twitter_enabled")
        }
    }
    
    class func set(#login: String, authKey: String){
        self.login = login
        self.authKey = authKey
    }
    
    class func doesExist() -> Bool{
        if login == nil{ return false }
        if authKey == nil{ return false }
        return true
    }
    
    func friends(#success: ([Hacker]) -> ()) -> () {
        func onFetch(result: AnyObject){
            var hackersJSON = JSON(result)["friends"].arrayValue
            var hackers: Array<Hacker> = []
            
            hackers = hackersJSON.map({
                (hacker) -> Hacker in
                return Hacker(json: hacker)
            })
            success(hackers)
        }
        
        Hackinat.sharedInstance.fetchMyFriends(onFetch)
    }
    
    func sendFriendshipRequest(toBeFriend: Hacker,
        onsuccess: ()->()){
        Hackinat.sharedInstance.sendFriendshipRequest(toBeFriend.login, success: onsuccess)
    }
    
    class func hacker() -> Hacker?{
        if doesExist(){
            let _hacker = CurrentHackerStruct.hacker
            
            if _hacker.login == "" {
                let _new_hacker = Hacker(login: login!, authKey: authKey!)
                
                CurrentHackerStruct.hacker = _new_hacker
                CurrentHackerStruct.hacker.fetchFullProfile(success: {})
                
                return _new_hacker
            }
    
            return _hacker
        }
        
        return nil
    }
    
    
    class func clear(){
        Locksmith.deleteDataForUserAccount(userAccount)
        
        NSUserDefaults.standardUserDefaults().removeObjectForKey("login")
        NSUserDefaults.standardUserDefaults().removeObjectForKey("twitter_enabled")
        
        CurrentHackerStruct.hacker = Hacker(login: "")
    }
    
    
}
