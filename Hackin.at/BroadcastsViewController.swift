//
//  DashboardViewController.swift
//  Hackin.at
//
//  Created by Prateek on 12/17/14.
//  Copyright (c) 2014 Prateek Dayal. All rights reserved.
//

//
//  DashboardViewController.swift
//  Github Auth
//
//  Created by Prateek on 11/6/14.
//  Copyright (c) 2014 Prateek. All rights reserved.
//

import UIKit
import PureLayout

class BroadcastsViewController: UIViewController, UITableViewDelegate {
    
    var broadcastTableViewDataSource = BroadcastTableViewDataSource()
    var broadcastListing: BroadcastListing!
    var tableRefreshControl:TableRefreshControl!
    
    @IBAction func broadcastButtonPressed(sender: AnyObject) {
        var newBroadcastStoryBoard = UIStoryboard(name: "NewBroadcast", bundle: nil)
        let vc = newBroadcastStoryBoard.instantiateViewControllerWithIdentifier("newBroadcastViewController") as UINavigationController;
        self.presentViewController(vc, animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Broadcasts"
        setupListing()
        initListing()
    }
    
    override func updateViewConstraints() {
        self.broadcastListing.autoPinToTopLayoutGuideOfViewController(self, withInset: 0)
        self.broadcastListing.autoPinToBottomLayoutGuideOfViewController(self, withInset: 0)
        self.broadcastListing.autoPinEdgeToSuperviewEdge(ALEdge.Right)
        self.broadcastListing.autoPinEdgeToSuperviewEdge(ALEdge.Left)
        super.updateViewConstraints()
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var newBroadcastStoryBoard = UIStoryboard(name: "Broadcasts", bundle: nil)
        let vc = newBroadcastStoryBoard.instantiateViewControllerWithIdentifier("broadcastViewController") as BroadcastViewController;
        vc.broadcast = broadcastTableViewDataSource.broadcasts[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    private func setupListing(){
        broadcastListing = BroadcastListing(tableViewDataSource: broadcastTableViewDataSource, tableViewDelegate: self, pullToRefresh: true)
        self.view.addSubview(broadcastListing)
    }
    
    private func initListing(){
        broadcastListing.fetchAndRefresh()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}