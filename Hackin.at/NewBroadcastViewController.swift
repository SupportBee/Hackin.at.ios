//
//  NewBroadcastViewController.swift
//  Hackin.at
//
//  Created by Prateek on 12/17/14.
//  Copyright (c) 2014 Prateek Dayal. All rights reserved.
//

import UIKit
import TwitterKit

class NewBroadcastViewController: UIViewController, PlacesViewProtocol {
    
    var place: Place?
    var twitterLinked: Int?
    @IBOutlet weak var broadcastMessageTextView: UITextView!
    @IBOutlet weak var currentPlaceLabel: UILabel!
    
    @IBOutlet weak var postBroadcastButton: UIButton!
    
    @IBOutlet weak var postToTwitterSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        postToTwitterSwitch.on = false
        twitterLinked = CurrentHacker.twitterEnabled!
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
                    
                    CurrentHacker.hacker()!.updateTwitterCredentials(authToken: session.authToken, authSecret: session.authTokenSecret, success: {
                        self.twitterLinked = 1
                        CurrentHacker.twitterEnabled = self.twitterLinked!
                        }, failure: {
                            self.postToTwitterSwitch.on = false
                    })
                    
                } else {
                    self.postToTwitterSwitch.on = false
                }
            }
        }
    }
    
    
    func placeSelected(place: Place) {
        println("Hacker is at \(place)")
        self.place = place
        var placeName = place.name
        currentPlaceLabel.text = "You are at \(placeName)"
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    @IBAction func postBroadcast(sender: AnyObject) {
        let postToTwitter = postToTwitterSwitch.on ? "true" : "false"
        let placeID = self.place!.id 
        Hackinat.sharedInstance.broadcast(login: CurrentHacker.login!, authKey: CurrentHacker.authKey!, message: broadcastMessageTextView.text, placeID: placeID, postToTwitter: postToTwitter, success: broadcastSuccessHandler)
    }

    private func broadcastSuccessHandler(responseJSON:AnyObject!){
        dismissScreen()
    }
    
    func dismissScreen(){
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func cancelButtonPressed(sender: AnyObject) {
        dismissScreen()
    }
}
