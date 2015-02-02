//
//  Hackinat.swift
//  Hackin.at
//
//  Created by Avinasha Shastry on 02/02/15.
//  Copyright (c) 2015 Prateek Dayal. All rights reserved.
//

import Alamofire

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
    
    override init() {
        //httpClient = HttpClient()
    }
    
    func getHacker(#login:String, success: (AnyObject) -> ()){
        Alamofire.request(.GET, "\(baseDomain)/\(login)")
            .responseJSON { (_, _, JSON, _) in
                success(JSON!)
        }
    }
}
