//
//  Hackinat.swift
//  Hackin.at
//
//  Created by Avinasha Shastry on 02/02/15.
//  Copyright (c) 2015 Prateek Dayal. All rights reserved.
//

import Alamofire
import CoreLocation
import SwiftyJSON

enum Router: URLRequestConvertible {
    static let baseURLString = "http://staging.hackin.at"
    
    case SearchHackers(String)
    case GetMyFriends
    case CreateFriendship(String)
    case GetFriendshipRequests
    case AcceptFriendship(Int)
    case RejectFriendship(Int)
    
    var method: Alamofire.Method {
        switch self {
        case .SearchHackers,
        .GetMyFriends,
        .GetFriendshipRequests:
            return .GET
        case .CreateFriendship:
            return .POST
        case .AcceptFriendship:
            return .POST
        case .RejectFriendship:
            return .DELETE
        }
    }
    
    var path: String {
        switch self {
        case .SearchHackers:
            return "/search"
        case .GetMyFriends:
            return "/friends"
        case .CreateFriendship(let login):
            return "/\(login)/friend_request"
        case .GetFriendshipRequests:
            return "/friend_requests"
        case .AcceptFriendship(let requestID):
            return "/friend_requests/\(requestID)/accept"
        case .RejectFriendship(let requestID):
            return "/friend_requests/\(requestID)"
        }
    }
    
    var URLRequest: NSURLRequest {
        let URL = NSURL(string: Router.baseURLString)!
        let mutableURLRequest = NSMutableURLRequest(URL: URL.URLByAppendingPathComponent(path))
        mutableURLRequest.HTTPMethod = method.rawValue
        
        switch self {
        case .SearchHackers(let query):
            return Alamofire.ParameterEncoding.URL.encode(mutableURLRequest, parameters: ["query": query]).0
        default:
            return mutableURLRequest
        }
    }

}

class Hackinat: NSObject {
    class var sharedInstance: Hackinat {
        struct Singleton {
            static let instance = Hackinat()
        }
        
        return Singleton.instance
    }
  
    let apiBaseDomain = "http://staging.hackin.at"
    let manager: Alamofire.Manager!
    
    override init() {
        var defaultHeaders = Alamofire.Manager.sharedInstance.session.configuration.HTTPAdditionalHeaders ?? [:]
        defaultHeaders["X-TOKEN"] = CurrentHacker.authKey
       
        let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
        configuration.HTTPAdditionalHeaders = defaultHeaders
        
        manager = Alamofire.Manager(configuration: configuration)
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
    
    func searchHackers(searchTerm: String, success: (AnyObject) -> ()){
        manager.request(Router.SearchHackers(searchTerm))
            .responseJSON { (_, _, JSON, _) in
                success(JSON!)
        }
    }
    
    func fetchFriendshipRequests(success: ([FriendshipRequest]) -> ()){
        manager.request(Router.GetFriendshipRequests)
            .responseJSON { (_, _, json, _) in
                var requestsJSON = JSON(json!)["friend_requests"].arrayValue
                var requests: Array<FriendshipRequest> = []
                
                requests = requestsJSON.map({
                    (request) -> FriendshipRequest in
                    return FriendshipRequest(json: request)
                })
                success(requests)
        }
    }
    
    func fetchMyFriends(success: (AnyObject) -> (), failure: () -> () = {}){
        manager.request(Router.GetMyFriends)
            .responseJSON { (_, _, JSON, _) in
                println("JSON IS \(JSON)")
                success(JSON!)
        }
    }
    
    func sendFriendshipRequest(friendsLogin: String,
        success: () -> ()){
            manager.request(Router.CreateFriendship(friendsLogin))
                .response {(_) in
                    success()
                    }
    }
    
    func acceptFriendshipRequest(requestID: Int, success: () -> ()){
            manager.request(Router.AcceptFriendship(requestID))
                .response {(_) in
                    success()
                    }
    }

    func rejectFriendshipRequest(requestID: Int, success: () -> ()){
            manager.request(Router.RejectFriendship(requestID))
                .response {(_) in
                    success()
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
