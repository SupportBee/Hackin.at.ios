//
//  Hacker.swift
//  Hackin.at
//
//  Created by Avinasha Shastry on 02/02/15.
//  Copyright (c) 2015 Prateek Dayal. All rights reserved.
//

class Hacker: NSObject {
    var authKey:String?
    let login:String
    
    init(login: String) {
        self.login = login
    }
    
    convenience init(login: String, authKey: String){
        self.init(login: login)
        self.authKey = authKey
    }
}