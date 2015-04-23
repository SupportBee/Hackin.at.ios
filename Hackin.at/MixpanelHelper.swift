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
        let api_key = NSBundle.mainBundle().infoDictionary?["MIXPANEL_API_KEY"] as! String
        Mixpanel.sharedInstanceWithToken(
            api_key)
    }
    
    func identifyCurrentUser(){
        instance.identify(CurrentHacker.hacker()?.externalIdentity)
    }
    
    func trackLogin(){
        instance.track("Login")
    }

    func trackPushNotification(type: String){
        instance.track("Open on Push", properties: [type: type])
    }
    
    func trackOpen(){
        instance.track("Open")
    }
    
}