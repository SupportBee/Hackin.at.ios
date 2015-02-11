//
//  PlaceViewController.swift
//  Hackin.at
//
//  Created by Prateek on 1/6/15.
//  Copyright (c) 2015 Prateek Dayal. All rights reserved.
//

import UIKit
import GoogleMaps

class PlaceViewController: UIViewController {
    
    var place: Place!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var latLongLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var mapView: GMSMapView!
    
    override func viewDidLoad() {
        
        let name = place!.name
        let location = place!.location

        println("At \(place) \(name) \(location)")
        
        nameLabel.text = name
        latLongLabel.text = "\(location.longitude),\(location.latitude)"
        
    }

}