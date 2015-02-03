//
//  ProfileViewController.swift
//  Github Auth
//
//  Created by Prateek on 11/10/14.
//  Copyright (c) 2014 Prateek. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var loginLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var companyLabel: UILabel!
    
    @IBOutlet weak var followersCountLabel: UILabel!
    @IBOutlet weak var reposCountLabel: UILabel!
    
    @IBOutlet weak var followButtonLabel: UIButton!
    
    @IBOutlet weak var profileImage: UIImageView!
    
    var hacker:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        println("Profile viewDidLoad")
        setupLoggedInUser()
        populateBasicInfo()
        fetchUserDetails()
        
        // Do any additional setup after loading the view.
    }
    @IBAction func followButtonPressed(sender: AnyObject) {
        println("so you want to follow huh!")
    }
    
    func setupLoggedInUser(){
        //self.login = NSUserDefaults.standardUserDefaults().objectForKey("login") as String
        if self.hacker == nil {
            self.hacker = login
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func fetchUserDetails(){
        Hackinat.sharedInstance.getHacker(login: hacker, success: renderFullProfile)
    }
    
    func renderFullProfile(userJSON:AnyObject!){
        var userDetails = JSON(userJSON)["hacker"]
        var avatarURL = userDetails["avatar_url"].string
        
        // Personal Info
        nameLabel.text = userDetails["name"].string
        companyLabel.text = userDetails["company"].string
        
        // Counts
        var reposCount = userDetails["github_repos"].int!
        var followersCount = userDetails["github_followers"].int!
        
        println(reposCount)
        println(reposCount)
        
        reposCountLabel.text = "\(reposCount) Repos"
        followersCountLabel.text = "\(followersCount) Followers"
        
        Alamofire.request(.GET, avatarURL!)
            .response{ (_, _, data, _) in
                self.profileImage.image = UIImage(data: (data as NSData) )
        }
        println(userDetails["name"])
    }
    
    func populateBasicInfo(){
        loginLabel.text = hacker
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