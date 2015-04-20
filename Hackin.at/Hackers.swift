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
    
    func hackersFetched()
    
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
    
    
        
}

class MyFriendsDataSource: HackersDataSource {
    
    func onFetch(hackers: [Hacker]){
        self.hackers = hackers
        delegate?.hackersFetched()
    }
    
    override func fetch(){
        CurrentHacker().friends(success: onFetch)
    }
    
}

class FriendsofHackerDataSource: HackersDataSource {
    
    var hacker: Hacker!
    
    init(hacker: Hacker){
        self.hacker = hacker
    }
    
    func onFetch(friends: [Hacker]){
        self.hackers = friends
        delegate?.hackersFetched()
    }
    
    
    override func fetch() {
        Hackinat.sharedInstance.fetchFriends(hacker.login, success: onFetch)
    }
    
    
}

class MyPendingFriendsDataSource: HackersDataSource {
    
    func onFetch(requests: [FriendshipRequest]){
        let toBeFriends = requests.map({(request) -> Hacker in
            let pendingFriend = request.sender
            pendingFriend.friendRequest = request
            return pendingFriend
        })
        self.hackers = toBeFriends
        delegate?.hackersFetched()
    }

    override func fetch(){
        FriendshipRequest.all(onFetch)
    }
    
}