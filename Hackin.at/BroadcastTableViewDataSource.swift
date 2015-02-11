//
//  BroadcastTableViewDataSource.swift
//  Hackin.at
//
//  Created by Avinasha Shastry on 11/02/15.
//  Copyright (c) 2015 Prateek Dayal. All rights reserved.
//

import Foundation
import UIKit

class BroadcastTableViewDataSource:NSObject, UITableViewDataSource{
    var broadcasts: Array<Broadcast> = []
    
    func fetchBroadcasts(#success: () -> ()){
        func onFetch(broadcasts: [Broadcast]){
            self.broadcasts = broadcasts
            success()
        }
        Broadcast.fetchBroadcasts(success: onFetch)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.broadcasts.count;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(
            "BroadcastCell", forIndexPath:indexPath) as BroadcastTableViewCell
        let broadcast = broadcasts[indexPath.row]
        cell.setupViewData(broadcast)
        return cell
    }
}