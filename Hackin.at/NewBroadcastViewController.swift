//
//  NewBroadcastViewController.swift
//  Hackin.at
//
//  Created by Prateek on 12/17/14.
//  Copyright (c) 2014 Prateek Dayal. All rights reserved.
//

import UIKit
import Alamofire
import TwitterKit
import SwiftyJSON

class NewBroadcastViewController: UIViewController, PlacesViewProtocol {
    
    var place: JSON?
    var twitterLinked: Int?
    @IBOutlet weak var broadcastMessageTextView: UITextView!
    @IBOutlet weak var currentPlaceLabel: UILabel!
    
    @IBOutlet weak var postBroadcastButton: UIButton!
    
    @IBOutlet weak var postToTwitterSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        postToTwitterSwitch.on = false
        twitterLinked = NSUserDefaults.standardUserDefaults().objectForKey("twitterLinked") as? Int
        if twitterLinked == 1 {
            postToTwitterSwitch.on = true
        }
        
    }
    
    override func viewDidAppear(animated: Bool) {
        
        if place == nil {
            println("There is no place!")
            var placesStoryboard = UIStoryboard(name: "Places", bundle: nil)
            let vc = placesStoryboard.instantiateViewControllerWithIdentifier("placesViewController") as PlacesViewController;
            vc.delegate = self
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    
    
    @IBAction func twitterSwitchToggled(sender: AnyObject) {
        if postToTwitterSwitch.on && twitterLinked == 0 {
            Twitter.sharedInstance().logInWithCompletion {
                (session, error) -> Void in
                if (session != nil) {
                    Hackinat.sharedInstance.updateHackerTwitterCredentials(login: login, authToken: session.authToken, authSecret: session.authTokenSecret, authKey: authKey, success: {
                            self.twitterLinked = 1
                            NSUserDefaults.standardUserDefaults().setObject(self.twitterLinked!, forKey: "twitterLinked")
                        }, failure: {
                            self.postToTwitterSwitch.on = false
                        }
                    )
                } else {
                    self.postToTwitterSwitch.on = false
                }
            }
        }
    }
    
    
    func placeSelected(place: JSON) {
        println("Hacker is at \(place)")
        self.place = place
        var placeName = place["name"]
        currentPlaceLabel.text = "You are at \(placeName)"
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    @IBAction func postBroadcast(sender: AnyObject) {
        let postToTwitter = postToTwitterSwitch.on ? "true" : "false"
        let parameters = [
            "log": [
                "message": broadcastMessageTextView.text,
                "place_id": self.place!["id"].stringValue,
                "client_id": 1,
                "twitter_cross_post": postToTwitter
            ]
        ]
        println("Ok! I am going to post this broadcast \(parameters)")
        Alamofire.request(.POST, "\(baseDomain)/logs?auth_key=\(authKey)", parameters: parameters)
            .validate()
            .responseJSON({ (_, _, JSON, _) in
                println("Posted \(JSON)")
                self.dismissScreen()
            })
    }

    func dismissScreen(){
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func cancelButtonPressed(sender: AnyObject) {
        dismissScreen()
    }
}
