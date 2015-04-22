//
//  PushNotificationHandler.swift
//  Hackin.at
//
//  Created by Avinasha Shastry on 23/03/15.
//  Copyright (c) 2015 Prateek Dayal. All rights reserved.
//

import Foundation

class PushNotificationHandler {
    class func handle(data: PushNotificationData){
        if(!CurrentHacker.doesExist()){ return }
        if(CurrentHacker.login != data.login){ return }
        
        switch data.type {
        case "friend.request.received":
            mainTabbar?.selectedIndex = 1
        case "friend.request.accepted":
            mainTabbar?.selectedIndex = 2
        default:
            println("Unhandled Push Notification - \(data.type)")
        }
    }
}
