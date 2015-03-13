//
//  Hackinat.swift
//  Hackin.at
//
//  Created by Avinasha Shastry on 02/02/15.
//  Copyright (c) 2015 Prateek Dayal. All rights reserved.
//

import Alamofire
import CoreLocation


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
    //let apiBaseDomain = "https://hackin.at"
    //let apiBaseDomain = "http://lvh.me:3000"
    let apiBaseDomain = "http://staging.hackin.at"
    
    override init() {
        //httpClient = HttpClient()
    }
    
    var githhubAuthURL:String { return "\(apiBaseDomain)/auth/github?api=true" }
    
    func getHacker(#login:String, authKey:String = "", success: (AnyObject) -> ()){
        var profileURL = "\(apiBaseDomain)/\(login)"
        if authKey != "" {
            profileURL = "\(profileURL)?auth_key=\(authKey)"
        }
        
        Alamofire.request(.GET, profileURL)
            .responseJSON { (_, _, JSON, _) in
                success(JSON!)
        }
    }
    
    func searchHackers(#authKey: String, searchTerm: String, success: (AnyObject) -> ()){
        var searchURL = "\(apiBaseDomain)/search?auth_key=\(authKey)&query=\(searchTerm)"
        Alamofire.request(.GET, searchURL)
            .responseJSON { (_, _, JSON, _) in
                success(JSON!)
        }
    }
    
    func fetchNearbyHackers(#authKey: String, location: CLLocationCoordinate2D, success: (AnyObject) -> (), failure: () -> () = {}){

        let ll = "\(location.latitude),\(location.longitude)"
        let url = "\(apiBaseDomain)/hackers/nearby?auth_key=\(authKey)&ll=\(ll)"
        
        Alamofire.request(.GET, url)
            .responseJSON { (_, _, JSON, _) in
                success(JSON!)
        }

    }
    
    func fetchFriends(#authKey: String, success: (AnyObject) -> (), failure: () -> () = {}){
        
        let url = "\(apiBaseDomain)/friends?auth_key=\(authKey)"
        Alamofire.request(.GET, url)
            .responseJSON { (_, _, JSON, _) in
                println("JSON IS \(JSON)")
                success(JSON!)
        }
    }
    
    func updateHackerTwitterCredentials(#login:String, authKey: String, authToken: String, authSecret: String,  success: () -> (), failure: () -> ()){
        
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
    
    func fetchCurrentHackerBroadcasts(#authKey:String, success: (AnyObject) -> ()){
        var broadcastsURL = "\(apiBaseDomain)/logs?auth_key=\(authKey)"
        
        Alamofire.request(.GET, broadcastsURL)
            .responseJSON { (_, _, JSON, _) in
                success(JSON!)
        }
    }
    
    func fetchPlacesAroundLocation(#authKey:String, location: CLLocationCoordinate2D, success: (AnyObject) -> (), failure: () -> () = {}){
        var placesURL = "\(apiBaseDomain)/places?auth_key=\(authKey)&ll=\(location.latitude),\(location.longitude)"
        println("Let's get the places around")
        Alamofire.request(.GET, placesURL)
            .responseJSON { (_, _, JSON, _) in
                success(JSON!)
        }
    }
    
    func fetchCurrentHackerNotifications(#login:String, authKey:String, success: (AnyObject) -> (), failure: () -> () = {}){
        var notificationsURL = "\(apiBaseDomain)/\(login)/notifications?auth_key=\(authKey)"
        println("Let's get the notifications")
        
        Alamofire.request(.GET, notificationsURL)
            .responseJSON { (_, _, JSON, _) in
                success(JSON!)
        }
    }
    
    
}
