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
        case "friend.request.sent":
            println("friend.request.sent")
        case "friend.request.accepted":
            println("friend.request.accepted")
        default:
            println("default")
        }
    }
}
