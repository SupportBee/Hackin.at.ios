//
//  NewBroadcastViewController.swift
//  Hackin.at
//
//  Created by Prateek on 12/17/14.
//  Copyright (c) 2014 Prateek Dayal. All rights reserved.
//

import UIKit
import TwitterKit
import SZTextView

class NewBroadcastViewController: UIViewController, PlacesViewProtocol {
    
    var place: Place?
    var twitterLinked: Int?
    
    @IBOutlet weak var broadcastMessageTextView: SZTextView!
    @IBOutlet weak var currentPlaceLabel: UILabel!
    
    @IBOutlet weak var hackerSummaryView: HackerSummaryView!
    @IBOutlet weak var postBroadcastButton: UIButton!
    
    @IBOutlet weak var postToTwitterSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        renderHackerSummary()
        
        broadcastMessageTextView.placeholder = "What are you hackin.at?"
        broadcastMessageTextView.backgroundColor = AppColors.textBackground
        
        postToTwitterSwitch.on = false
        twitterLinked = CurrentHacker.twitterEnabled!
        if twitterLinked == 1 {
            postToTwitterSwitch.on = true
        }
        
    }
    
    func renderHackerSummary(){
        hackerSummaryView.hacker = CurrentHacker.hacker()
        println(CurrentHacker.hacker())
        hackerSummaryView.renderView()
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
        if postToTwitterSwitch.on && twitterLinked == 0 { connectWithTwitter() }
    }
    
    func connectWithTwitter(){
        Twitter.sharedInstance().logInWithCompletion {
            (session, error) -> Void in
            if (session != nil) {
                self.updateCurrentHackerTwitterCredentials(session.authToken, authSecret: session.authTokenSecret)
            } else {
                self.onTwitterAuthFailure(error.description)
            }
        }
    }
    
    private func updateCurrentHackerTwitterCredentials(authToken: String, authSecret: String){
        CurrentHacker.hacker()!.updateTwitterCredentials(authToken: authToken, authSecret: authSecret, success: {
                self.twitterLinked = 1
                CurrentHacker.twitterEnabled = self.twitterLinked!
            }, failure: {
                self.postToTwitterSwitch.on = false
        })
    }
    
    private func onTwitterAuthFailure(errorMessage:String){
        let alertController = UIAlertController(title: "Cannot Connect to Twitter", message: "Please contact support@hackin.at. \n Error: \(errorMessage). ", preferredStyle: .Alert)
        let OKAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
        alertController.addAction(OKAction)
        self.presentViewController(alertController, animated: true, completion: nil)
        
        self.postToTwitterSwitch.on = false
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
        
        var broadcast = Broadcast(message: broadcastMessageTextView.text, hacker: CurrentHacker.hacker()!)
        broadcast.place = self.place!
        broadcast.postToTwitter = postToTwitter
        broadcast.create(success: broadcastSuccessHandler)
    }

    private func broadcastSuccessHandler(){
        dismissScreen()
    }
    
    func dismissScreen(){
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func cancelButtonPressed(sender: AnyObject) {
        dismissScreen()
    }
}
