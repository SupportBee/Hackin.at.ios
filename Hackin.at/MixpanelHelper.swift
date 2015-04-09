//
//  MixpanelHelper.swift
//  Hackin.at
//
//  Created by Prateek on 3/11/15.
//  Copyright (c) 2015 Prateek Dayal. All rights reserved.
//

import Mixpanel

class MixpanelHelper {
    
    var instance: Mixpanel!
    
    // Class func setup should be called before 
    // creating an instance
    init() {
        instance = Mixpanel.sharedInstance()
    }
    
    class func setup(){
        Mixpanel.sharedInstanceWithToken(
            "6642e6642c98e47da5d2a327f73440d2")
    }
    
    func identifyCurrentUser(){
        instance.identify(CurrentHacker.hacker()?.externalIdentity)
    }
    
    func trackLogin(){
        instance.track("Login")
    }
    
    func trackOpen(){
        instance.track("Open")
    }
    
}