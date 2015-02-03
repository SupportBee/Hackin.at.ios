//
//  CurrentHacker.swift
//  Hackin.at
//
//  Created by Avinasha Shastry on 03/02/15.
//  Copyright (c) 2015 Prateek Dayal. All rights reserved.
//

class CurrentHacker:NSObject {
    
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
        return NSUserDefaults.standardUserDefaults().objectForKey("auth_key") as? String
        }
        
        set{
            NSUserDefaults.standardUserDefaults().setObject(newValue!, forKey: "auth_key")
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
        if login == nil{
            return false
        }
        return true
    }
    
    class func hacker() -> Hacker?{
        if doesExist(){
            var _hacker = Hacker(login: login!, authKey: authKey!)
            return _hacker
        }
        return nil
    }
    
    class func clear(){
        NSUserDefaults.standardUserDefaults().removeObjectForKey("login")
        NSUserDefaults.standardUserDefaults().removeObjectForKey("auth_key")
    }
    
    
}
