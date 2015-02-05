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
        postLoginInit()
    }
    
    func setupHackerPrefs(){
        if CurrentHacker.doesExist() {
            if CurrentHacker.twitterEnabled == nil{
                CurrentHacker.hacker()!.checkTwitterAccess(success: setupHackerDetails)
            }
        }
    }
    
    func setupHackerDetails(twitterEnabled:Int){
        CurrentHacker.twitterEnabled = twitterEnabled
    }
    
    func postLoginInit(){
        setupHackerPrefs()
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
