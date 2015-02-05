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

    let message:String
    var id: String?
    var place:Place?
    var hacker:Hacker
    var postToTwitter = "false"
    
    init(message: String, hacker: Hacker){
        self.message = message
        self.hacker = hacker
    }

    convenience init(json: JSON){
        self.init(message: json["message"].stringValue, hacker: Hacker(json: json["logged_by"]))
        self.id = json["id"].stringValue
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
    
    func create(#success: () -> (), failure: () -> () = {}){
        
        func onPost(result: AnyObject){
            success()
        }
        
        Hackinat.sharedInstance.broadcast(login: hacker.login, authKey: hacker.authKey!, message: message, placeID: place!.id, postToTwitter: postToTwitter, success: onPost)
    }
}
