//
//  NotificationViewController.swift
//  Hackin.at
//
//  Created by Prateek on 12/24/14.
//  Copyright (c) 2014 Prateek Dayal. All rights reserved.
//

import UIKit
import SwiftyJSON
import PureLayout


class NotificationsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var notificationsTableView: UITableView!
    var notifications: Array<JSON> = []
    var tableRefreshControl:TableRefreshControl!
    
    override func viewDidLoad() {
        title = "Notifications"
        setupTableView()
        setupAutoRefresh()
        notificationsController = self
    }
    
    override func viewDidAppear(animated: Bool) {
        fetchNotifications()
    }
    
    func setupTableView(){
        notificationsTableView = UITableView()
        view.addSubview(notificationsTableView)
        notificationsTableView.delegate = self
        notificationsTableView.dataSource = self
        notificationsTableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        notificationsTableView.tableFooterView = UIView(frame: CGRectZero)
    }
    
    func setupAutoRefresh(){
         tableRefreshControl = TableRefreshControl.setupForTableViewWithAction(
            tableView: notificationsTableView,
            target: self,
            action: "fetchNotifications"
        )
    }
    
    func fetchNotifications() {
        Hackinat.sharedInstance.fetchCurrentHackerNotifications(login: CurrentHacker.login!, authKey: CurrentHacker.authKey!, success: renderNotifications)
    }
    
    func renderNotifications(notificationsJSON: AnyObject!) {
        if (tableRefreshControl.refreshing) { tableRefreshControl.endRefreshing()}
        notifications = JSON(notificationsJSON)["notifications"].arrayValue
        notificationsTableView.reloadData()
    }
 
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notifications.count
    }
    
    override func updateViewConstraints() {
        notificationsTableView.autoPinEdgeToSuperviewEdge(ALEdge.Top)
        notificationsTableView.autoPinEdgeToSuperviewEdge(ALEdge.Bottom)
        notificationsTableView.autoPinEdgeToSuperviewEdge(ALEdge.Right)
        notificationsTableView.autoPinEdgeToSuperviewEdge(ALEdge.Left)
        super.updateViewConstraints()
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "cell")
        let notification = self.notifications[indexPath.row]
        let actor = Hacker(json: notification["actor"])
        cell.textLabel?.text = notification["message"].stringValue
        
        let profileImageSize = AppTheme.HackerContactView.profileImageSize
        
        cell.imageView!.frame = CGRectMake(0, 0, profileImageSize, profileImageSize)
        Helpers.showProfileImage(actor, imageView: cell.imageView!)
        Helpers.roundImageView(cell.imageView!)
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        println("You selected \(indexPath.row)")
        let hacker = Hacker(json: self.notifications[indexPath.row]["actor"])
        let vc = AppScreens.Profile(hacker).vc
        navigationController?.pushViewController(vc, animated: true)
    }


}