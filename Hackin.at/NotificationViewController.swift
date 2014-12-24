//
//  NotificationViewController.swift
//  Hackin.at
//
//  Created by Prateek on 12/24/14.
//  Copyright (c) 2014 Prateek Dayal. All rights reserved.
//

import UIKit


class NotificationViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var notificationsTableView: UITableView!
    var notifications: Array<JSON>?
    
    override func viewDidLoad() {
        println("Going to fetch your notifications")
        self.notificationsTableView.delegate = self
        self.notificationsTableView.dataSource = self
        self.notificationsTableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        fetchNotifications()
    }
    
    func fetchNotifications() {
        
        var notificationsURL = "\(baseDomain)/\(login)/notifications?auth_key=\(authKey)"
        println("Let's get the places around")
        
        Alamofire.request(.GET, notificationsURL)
            .responseJSON { (_, _, JSON, _) in
                self.renderNotifications(JSON)
        }
        
    }
    
    func renderNotifications(notificationsJSON: AnyObject!) {
        notifications = JSON(notificationsJSON)["notifications"].arrayValue
        notificationsTableView.reloadData()
    }
 
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "cell")
        cell.textLabel?.text = "I am a notificaiton"
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    }


}