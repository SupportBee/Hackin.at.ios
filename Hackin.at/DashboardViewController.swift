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
import Alamofire
import SwiftyJSON

class DashboardViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var broadcastsTableView: UITableView!
    
    var broadcasts: Array<JSON> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBarStyle()
        setupTableViewStyle()
       // Do any additional setup after loading the view.
        self.broadcastsTableView.delegate = self
        self.broadcastsTableView.dataSource = self
        self.broadcastsTableView.registerNib(
            UINib(nibName:"BroadcastTableViewCell", bundle:nil), forCellReuseIdentifier: "BroadcastCell")
        fetchBroadcasts()
    }
    
    func setupNavigationBarStyle(){
        self.navigationController?.navigationBar.barStyle = UIBarStyle.Black
        self.navigationController?.navigationBar.translucent = false
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 242.0/255.0, green: 99.0/255.0, blue: 99.0/255.0, alpha: 1)
    }
    
    func setupTableViewStyle(){
        self.broadcastsTableView.estimatedRowHeight = 100
        self.broadcastsTableView.rowHeight = UITableViewAutomaticDimension 
        
    }
    
    
    func fetchBroadcasts(){
        Hackinat.sharedInstance.fetchCurrentHackerBroadcasts(authKey: authKey, success: renderBroadcasts)        
    }
    
    func renderBroadcasts(broadcastsJSON:AnyObject!){
        broadcasts = JSON(broadcastsJSON)["logs"].arrayValue
        self.broadcastsTableView.reloadData()
    }
 
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func broadcastButtonPressed(sender: AnyObject) {
        var newBroadcastStoryBoard = UIStoryboard(name: "NewBroadcast", bundle: nil)
        let vc = newBroadcastStoryBoard.instantiateViewControllerWithIdentifier("newBroadcastViewController") as UINavigationController;
        self.presentViewController(vc, animated: true, completion: nil)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        println("Number of rows \(self.broadcasts.count)")
        return self.broadcasts.count;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(
            "BroadcastCell", forIndexPath:indexPath) as BroadcastTableViewCell
        let broadcast = broadcasts[indexPath.row]
        let hacker = broadcast["logged_by"]["login"].stringValue
        let avatarURL = broadcast["logged_by"]["avatar_url"].stringValue
        println(avatarURL)
        let message = broadcast["message"].stringValue
        let placeName = broadcast["logged_at"]["place"]["name"].stringValue
        
        cell.loginLabel.text = hacker
        cell.messageText.text = message
        cell.whereLabel.text = placeName
        
        Alamofire.request(.GET, avatarURL)
            .response{ (_, _, data, _) in
                cell.profileImageView.image = UIImage(data: (data as NSData) )
        }
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var newBroadcastStoryBoard = UIStoryboard(name: "Broadcasts", bundle: nil)
        let vc = newBroadcastStoryBoard.instantiateViewControllerWithIdentifier("broadcastViewController") as BroadcastViewController;
        vc.broadcast = broadcasts[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }

 
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
}