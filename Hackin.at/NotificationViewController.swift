//
//  NotificationViewController.swift
//  Hackin.at
//
//  Created by Prateek on 12/24/14.
//  Copyright (c) 2014 Prateek Dayal. All rights reserved.
//

import UIKit
import SwiftyJSON


class NotificationViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var notificationsTableView: UITableView!
    var notifications: Array<JSON> = []
    
    override func viewDidLoad() {
        println("Going to fetch your notifications")
        self.notificationsTableView.delegate = self
        self.notificationsTableView.dataSource = self
        self.notificationsTableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        fetchNotifications()
    }
    
    func fetchNotifications() {
        Hackinat.sharedInstance.fetchCurrentHackerNotifications(login: login, authKey: authKey, success: renderNotifications)
    }
    
    func renderNotifications(notificationsJSON: AnyObject!) {
        notifications = JSON(notificationsJSON)["notifications"].arrayValue
        notificationsTableView.reloadData()
    }
 
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notifications.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "cell")
        cell.textLabel?.text = self.notifications[indexPath.row]["message"].stringValue
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        println("You selected \(indexPath.row)")
        let hacker = self.notifications[indexPath.row]["actor"]["login"].stringValue
        println("Should show you profile of \(hacker)")
        let vc = self.storyboard?.instantiateViewControllerWithIdentifier("profileViewController") as ProfileViewController;
        vc.hacker = hacker
        self.navigationController?.pushViewController(vc, animated: true)
    }


}