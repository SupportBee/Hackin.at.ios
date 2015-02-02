//
//  Hackinat.swift
//  Hackin.at
//
//  Created by Avinasha Shastry on 02/02/15.
//  Copyright (c) 2015 Prateek Dayal. All rights reserved.
//

import Alamofire

//class HttpClient {
//
//}

class Hackinat: NSObject {
    class var sharedInstance: Hackinat {
        struct Singleton {
            static let instance = Hackinat()
        }
        
        return Singleton.instance
    }
  
    //private let httpClient: HttpClient
    private let apiBaseDomain = "https://hackin.at"
    
    override init() {
        //httpClient = HttpClient()
    }
    
    func getHacker(#login:String, success: (AnyObject) -> ()){
        Alamofire.request(.GET, "\(apiBaseDomain)/\(login)")
            .responseJSON { (_, _, JSON, _) in
                success(JSON!)
        }
    }
    
    func updateHackerTwitterCredentials(#login:String, authToken: String, authSecret: String, authKey: String, success: () -> (), failure: () -> ()){
        
        let parameters = [
            "user": [
                "auth_token": authToken,
                "auth_secret": authSecret
            ]
        ]
        
        Alamofire.request(.PUT, "\(apiBaseDomain)/\(login)/twitter_credentials?auth_key=\(authKey)", parameters: parameters)
            .validate()
            .response({ (_, _, succ, err) in
                if(succ != nil){
                    success()
                }else{
                    failure()
                }
            })
    }
    
    
}
