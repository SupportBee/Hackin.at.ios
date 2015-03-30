//
//  PushNotificationData.swift
//  Hackin.at
//
//  Created by Avinasha Shastry on 23/03/15.
//  Copyright (c) 2015 Prateek Dayal. All rights reserved.
//

import Foundation

struct PushNotificationData {
    var login: String
    var type: String
    var actor: Hacker? = nil
    var friendRequestID: String? = nil
}