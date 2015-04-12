//
//  Hackers.swift
//  Hackin.at
//
//  Created by Prateek on 4/12/15.
//  Copyright (c) 2015 Prateek Dayal. All rights reserved.
//

protocol HackersDataSourceProtocol {
    
    func fetch()
    func count() -> Int
    
}

protocol HackersDataSourceDelegate {
    
    func hackersFetched([Hacker])
    
}

public class HackersDataSource: NSObject, HackersDataSourceProtocol {
    
    var hackers: [Hacker]? = []
    var delegate: HackersDataSourceDelegate? = nil
    
    func count() -> Int {
        return 0
    }
    
    func fetch() {
    }
    
}