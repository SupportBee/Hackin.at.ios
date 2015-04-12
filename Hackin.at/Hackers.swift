//
//  Hackers.swift
//  Hackin.at
//
//  Created by Prateek on 4/12/15.
//  Copyright (c) 2015 Prateek Dayal. All rights reserved.
//

protocol HackersDataSourceProtocol {
    
    func fetch()
    var count: Int { get }
    
}

protocol HackersDataSourceDelegate {
    
    func hackersFetched([Hacker])
    
}

class HackersDataSource: NSObject, HackersDataSourceProtocol {
    
    var hackers: [Hacker] = []
    var delegate: HackersDataSourceDelegate? = nil
    
    var count: Int {
        return hackers.count
    }
    
    func fetch() {
        // No-op
    }
    
    func onFetch(hackers: [Hacker]){
        self.hackers = hackers
        delegate?.hackersFetched(hackers)
    }
        
}

class MyFriendsDataSource: HackersDataSource {
    
    override func fetch(){
        CurrentHacker().friends(success: onFetch)
    }
    
}