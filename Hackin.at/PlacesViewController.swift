//
//  PlacesViewController.swift
//  Hackin.at
//
//  Created by Prateek on 12/18/14.
//  Copyright (c) 2014 Prateek Dayal. All rights reserved.
//


import UIKit
import Alamofire

class PlacesViewController: UIViewController {

    @IBOutlet var containerView: UIView!
    @IBOutlet weak var placesTableView: UITableView!
    
    var places: JSON!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchPlaces()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func fetchPlaces() {
        
        var placesURL = "\(baseDomain)/places?auth_key=\(authKey)&ll=\(currentLocation.latitude),\(currentLocation.longitude)"
        println("Let's get the places around")
        
        Alamofire.request(.GET, placesURL)
            .responseJSON { (_, _, JSON, _) in
                self.renderPlaces(JSON)
        }
        
    }
    
    func renderPlaces(placesJSON: AnyObject!) {
        places = JSON(placesJSON)["places"]
        println(places)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}