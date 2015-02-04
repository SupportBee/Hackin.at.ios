//
//  Broadcast.swift
//  Hackin.at
//
//  Created by Avinasha Shastry on 04/02/15.
//  Copyright (c) 2015 Prateek Dayal. All rights reserved.
//

import UIKit
import SwiftyJSON

class Broadcast: NSObject {

    let id: String
    let message:String
    var place:Place?
    var hacker:Hacker
    
    init(json: JSON){
        self.id = json["id"].stringValue
        self.message = json["message"].stringValue
        self.hacker = Hacker(json: json["logged_by"])
        if json["logged_at"]["place"]["id"] != nil {
            self.place = Place(json: json["logged_at"]["place"])
        }
    }
    
    class func fetchBroadcasts(#success: ([Broadcast]) -> ()){
        
        func onFetch(result: AnyObject){
            var broadcastsJSON = JSON(result)["logs"].arrayValue
            var broadcasts: Array<Broadcast> = []
            
            broadcasts = broadcastsJSON.map({
                (broadcast) -> Broadcast in
                return Broadcast(json: broadcast)
            })
            success(broadcasts)
        }
        
        Hackinat.sharedInstance.fetchCurrentHackerBroadcasts(authKey: CurrentHacker.authKey!, success: onFetch)
    }
}
