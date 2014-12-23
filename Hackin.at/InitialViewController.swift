//
//  InitialViewController.swift
//  Hackin.at
//
//  Created by Prateek on 12/23/14.
//  Copyright (c) 2014 Prateek Dayal. All rights reserved.
//

import UIKit
import CoreLocation

// All Globals here for now
//let baseDomain = "http://192.168.224.132:3000"
let baseDomain = "https://hackin.at"


var login: String!
var authKey: String!
var currentLocation: CLLocationCoordinate2D!

class InitialViewController: UIViewController, CLLocationManagerDelegate {
    
    // Location setup
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        login = NSUserDefaults.standardUserDefaults().objectForKey("login") as? String
        if login != nil {
            authKey = NSUserDefaults.standardUserDefaults().objectForKey("auth_key") as? String
            
            // Location Setup
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestWhenInUseAuthorization()
            locationManager.startUpdatingLocation()
        }
        println("should update locations")
    }
    
    
    override func viewDidAppear(animated: Bool) {
        if login == nil {
            let vc = self.storyboard?.instantiateViewControllerWithIdentifier("loginViewController") as LoginViewController;
            self.presentViewController(vc, animated: true, completion: nil)
        }
    }
 
    func locationManager(manager:CLLocationManager, didUpdateLocations locations:[AnyObject]) {
        var locationArray = locations as NSArray
        var locationObj = locationArray[0] as CLLocation
        currentLocation = locationObj.coordinate
        println("location = \(currentLocation)")
        locationManager.stopUpdatingLocation()
    }
    
    func locationManager(manager:CLLocationManager, didFailWithError error:NSError!) {
        println("failed \(error)")
    }
 
    
}
