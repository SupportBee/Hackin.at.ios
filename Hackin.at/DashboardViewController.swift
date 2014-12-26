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

class DashboardViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var broadcastsTableView: UITableView!
    
    var broadcasts: Array<JSON> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
       // Do any additional setup after loading the view.
        self.broadcastsTableView.delegate = self
        self.broadcastsTableView.dataSource = self
        self.broadcastsTableView.registerNib(
            UINib(nibName:"BroadcastTableViewCell", bundle:nil), forCellReuseIdentifier: "BroadcastCell")
        fetchBroadcasts()
    }
    
    func fetchBroadcasts(){
        var broadcastsURL = "\(baseDomain)/logs?auth_key=\(authKey)"
        
        Alamofire.request(.GET, broadcastsURL)
            .responseJSON { (_, _, JSON, _) in
                self.renderBroadcasts(JSON)
        }
        
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
    }
        func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        println("Number of rows \(self.broadcasts.count)")
        return self.broadcasts.count;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(
            "BroadcastCell", forIndexPath:indexPath) as UITableViewCell
        let placeName = broadcasts[indexPath.row]["name"].stringValue
        let broadcast = broadcasts[indexPath.row]
        let message = broadcast["message"].stringValue
        
        let hacker = broadcast["logged_by"]["login"].stringValue
        let loginLabel = cell.viewWithTag(1) as UILabel
        
        loginLabel.text = "\(hacker) says \(message)"
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        println("You selected the place #\(broadcasts[indexPath.row])!")
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