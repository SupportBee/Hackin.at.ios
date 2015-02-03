//
//  InitialViewController.swift
//  Hackin.at
//
//  Created by Prateek on 12/23/14.
//  Copyright (c) 2014 Prateek Dayal. All rights reserved.
//

import UIKit
import CoreLocation
import SwiftyJSON

// All Globals here for now
var currentLocation: CLLocationCoordinate2D!

class InitialViewController: UIViewController, CLLocationManagerDelegate, LoginViewDelegate {
    
    // Location setup
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(animated: Bool) {
        setupHackerAndKey()
        if CurrentHacker.doesExist() {
            postLoginInit()
        }else{
            showLoginView()
        }
    }
    
    func showLoginView(){
        let vc = self.storyboard?.instantiateViewControllerWithIdentifier("loginViewController") as LoginViewController;
        vc.delegate = self
        self.presentViewController(vc, animated: true, completion: nil)
    }
 
    func locationManager(manager:CLLocationManager, didUpdateLocations locations:[AnyObject]) {
        var locationArray = locations as NSArray
        var locationObj = locationArray[0] as CLLocation
        currentLocation = locationObj.coordinate
        println("acquired location \(currentLocation)")
        locationManager.stopUpdatingLocation()
    }
    
    func locationManager(manager:CLLocationManager, didFailWithError error:NSError!) {
        println("failed \(error)")
    }
    
    func hackerLoggedIn() {
        println("Hacker Logged In!")
        self.dismissViewControllerAnimated(true, completion: nil)
        setupHackerAndKey()
        postLoginInit()
    }
    
    func setupHackerAndKey(){
        if CurrentHacker.doesExist() {
            if CurrentHacker.twitterEnabled == nil{
                Hackinat.sharedInstance.getHacker(login: CurrentHacker.login!, authKey: CurrentHacker.authKey!, success: setupHackerDetails)
            }
        }
    }
    
    func setupHackerDetails(userJSON:AnyObject!){
        var userDetails = JSON(userJSON)["hacker"]
        CurrentHacker.twitterEnabled = userDetails["twitter_enabled"].int!
    }
    
    func postLoginInit(){
        setupLocationManager()
        launchApp()
    }
    
    func launchApp() {
        let vc = self.storyboard?.instantiateViewControllerWithIdentifier("mainViewController") as MainViewController;
        self.presentViewController(vc, animated: true, completion: nil)
    }
    
    func setupLocationManager(){
        // Location Setup
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
 
    
}
