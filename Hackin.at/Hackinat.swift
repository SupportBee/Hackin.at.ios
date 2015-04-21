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

//let apiBaseDomain = "http://staging.hackin.at"
let apiBaseDomain = "https://hackin.at"
//let apiBaseDomain = "http://lvh.me:3000"

enum Router: URLRequestConvertible {
    
    case GetHacker(String)
    case SearchHackers(String)
    case GetMyFriends
    case GetFriends(String)
    case CreateFriendship(String)
    case CreateDeviceToken(String)
    case DestroyDeviceToken
    case GetNotifications
    case GetFriendshipRequests
    case AcceptFriendship(Int)
    case DeleteFriendshipRequest(Int)
    case DeleteFriend(String)
    
    var method: Alamofire.Method {
        switch self {
        case .GetHacker,
        .SearchHackers,
        .GetMyFriends,
        .GetFriends,
        .GetFriendshipRequests,
        .GetNotifications:
            return .GET
        case .CreateFriendship, .CreateDeviceToken(_):
            return .POST
        case .AcceptFriendship:
            return .POST
        case .DeleteFriendshipRequest,
        .DeleteFriend,
        .DestroyDeviceToken:
            return .DELETE
        }
    }
    
    var path: String {
        switch self {
        case .GetHacker(let login):
            return "/\(login)"
        case .SearchHackers:
            return "/search"
        case .GetMyFriends:
            return "/friends"
        case .GetFriends(let login):
            return "/\(login)/friends"
        case .CreateFriendship(let login):
            return "/\(login)/friend_request"
        case .CreateDeviceToken(_), .DestroyDeviceToken:
            return "/iphone_device"
        case .GetNotifications:
            return "/notifications"
        case .GetFriendshipRequests:
            return "/friend_requests"
        case .AcceptFriendship(let requestID):
            return "/friend_requests/\(requestID)/accept"
        case .DeleteFriendshipRequest(let requestID):
            return "/friend_requests/\(requestID)"
        case .DeleteFriend(let login):
            return "/friends/\(login)"
        }
    }
    
    var URLRequest: NSURLRequest {
        let URL = NSURL(string: apiBaseDomain)!
        let mutableURLRequest = NSMutableURLRequest(URL: URL.URLByAppendingPathComponent(path))
        mutableURLRequest.HTTPMethod = method.rawValue
        
        switch self {
        case .SearchHackers(let query):
            return Alamofire.ParameterEncoding.URL.encode(mutableURLRequest, parameters: ["query": query]).0
        case .GetHacker(let login):
            return Alamofire.ParameterEncoding.URL.encode(mutableURLRequest, parameters: ["fetch_gh": true]).0
        case .CreateDeviceToken(let token):
            return Alamofire.ParameterEncoding.URL.encode(mutableURLRequest, parameters: ["iphone_device": [ "token": token]] ).0
        case .DestroyDeviceToken:
            return Alamofire.ParameterEncoding.URL.encode(mutableURLRequest, parameters: nil).0
        default:
            return mutableURLRequest
        }
    }

}

class Hackinat: NSObject {

    var githhubAuthURL:String { return "\(apiBaseDomain)/auth/github?api=true" }
    
    class var sharedInstance: Hackinat {
        
        struct Singleton {
            static let instance = Hackinat()
        }
        
        return Singleton.instance
    }
  
    var manager: Alamofire.Manager!
    
    override init() {
        super.init()
        resetAlamofireManager()
    }
    
    func resetAlamofireManager(){
        var defaultHeaders = Alamofire.Manager.sharedInstance.session.configuration.HTTPAdditionalHeaders ?? [:]
        defaultHeaders["X-TOKEN"] = CurrentHacker.authKey
        
        let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
        configuration.HTTPAdditionalHeaders = defaultHeaders
        
        manager = Alamofire.Manager(configuration: configuration)
    }
    
    
    
    func getHacker(#login:String, authKey:String = "", success: (AnyObject) -> ()){
        manager.request(Router.GetHacker(login))
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
                success(JSON!)
        }
    }
    
    func fetchFriends(login: String, success: ([Hacker]) -> ()){
         manager.request(Router.GetFriends(login))
            .responseJSON { (_, _, json, _) in
                var friendsJSON = JSON(json!)["hackers"].arrayValue
                var friends: Array<Hacker> = []
                
                friends = friendsJSON.map({
                    (friend) -> Hacker in
                    return Hacker(json: friend)
                })
                success(friends)
        }
    }
    
    func sendFriendshipRequest(friendsLogin: String,
        success: (FriendshipRequest) -> ()){
            manager.request(Router.CreateFriendship(friendsLogin))
                .responseJSON { (_, _, json, _) in
                    let friendshipReqJSON = JSON(json!)["friend_request"]
                    success(FriendshipRequest(json: friendshipReqJSON))
                }
                //.response {(_) in
                //    success()
                //}
    }
    
    func acceptFriendshipRequest(requestID: Int, success: () -> ()){
            manager.request(Router.AcceptFriendship(requestID))
                .response {(_) in
                    success()
                    }
    }
   
    func deleteFriendshipRequest(requestID: Int, success: () -> ()){
            manager.request(Router.DeleteFriendshipRequest(requestID))
                .response {(_) in
                    success()
                    }
    }

    func deleteFriend(login: String, success: () -> ()){
            manager.request(Router.DeleteFriend(login))
                .response {(_) in
                    success()
                    }
    }
    
    func syncDeviceToken(
        #token: String?,
        success: () -> (),
        failure: (NSError?) -> () = {
            (error) -> () in
        }
        ){
            if(token == nil){
                manager.request(Router.DestroyDeviceToken)
                    .response{ (req, res, data, error) in
                        if(res?.statusCode == 204){
                            success()
                        }else{
                            failure(error)
                        }
                }
            }else{
                manager.request(Router.CreateDeviceToken(token!))
                    .response{ (req, res, data, error) in
                        if(res?.statusCode == 204){
                            success()
                        }else{
                            failure(error)
                        }
                    }
            }
    }
    
    func fetchCurrentHackerNotifications(#login:String, authKey:String, success: (AnyObject) -> (), failure: () -> () = {}){
        manager.request(Router.GetNotifications)
            .responseJSON { (_, _, JSON, _) in
                success(JSON!)
        }
    }
    
    
    
    
    // Legacy API methods
    
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
        Alamofire.request(.GET, placesURL)
            .responseJSON { (_, _, JSON, _) in
                success(JSON!)
        }
    }
}
