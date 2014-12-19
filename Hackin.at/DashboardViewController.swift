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
import CoreLocation

// All Globals here for now

let baseDomain = "http://10.1.10.78.xip.io:3000"
//let baseDomain = "https://hackin.at"


var login: String!
var authKey: String!
var currentLocation: CLLocationCoordinate2D!

class DashboardViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var welcomeLabel: UILabel!
    
    
    // Location setup
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        login = NSUserDefaults.standardUserDefaults().objectForKey("login") as? String
        if login != nil {
            authKey = NSUserDefaults.standardUserDefaults().objectForKey("auth_key") as? String
            welcomeLabel.text = "Welcome to Hackin.at \(login)"
            
            // Location Setup
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestWhenInUseAuthorization()
            locationManager.startUpdatingLocation()
        }
        println("should update locations")
        // Do any additional setup after loading the view.
    }
    
    func locationManager(manager:CLLocationManager, didUpdateLocations locations:[AnyObject]) {
//        location["lat"] = locations[0].location.coordinate.latitude
//        location[1] = locations[0].location.coordinate.longitude
        var locationArray = locations as NSArray
        var locationObj = locationArray[0] as CLLocation
        currentLocation = locationObj.coordinate
        println("location = \(currentLocation)")
        locationManager.stopUpdatingLocation()
    }
    
    func locationManager(manager:CLLocationManager, didFailWithError error:NSError!) {
        println("failed \(error)")
    }
    
    override func viewDidAppear(animated: Bool) {
        if login == nil {
            let vc = self.storyboard?.instantiateViewControllerWithIdentifier("loginViewController") as LoginViewController;
            self.presentViewController(vc, animated: true, completion: nil)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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