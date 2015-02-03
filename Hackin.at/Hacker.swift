//
//  Hacker.swift
//  Hackin.at
//
//  Created by Avinasha Shastry on 02/02/15.
//  Copyright (c) 2015 Prateek Dayal. All rights reserved.
//

import SwiftyJSON

class Hacker: NSObject {
    var authKey:String?
    var userDetails:JSON?
    let login:String
    
    init(login: String) {
        self.login = login
    }
    
    convenience init(login: String, authKey: String){
        self.init(login: login)
        self.authKey = authKey
    }
    
    func fetchFullProfile(#success: () -> ()){
        
        func onFetch(json: AnyObject!){
            setUserDetails(json)
            success()
        }
        
        Hackinat.sharedInstance.getHacker(login: login, success: onFetch)
    }
    
    private func setUserDetails(userJSON:AnyObject!){
        self.userDetails = JSON(userJSON)["hacker"]
    }

}