//
//  PlaceViewController.swift
//  Hackin.at
//
//  Created by Prateek on 1/6/15.
//  Copyright (c) 2015 Prateek Dayal. All rights reserved.
//

import UIKit
import Alamofire

class PlaceViewController: UIViewController {
    
    var place: JSON!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var latLongLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    
    override func viewDidLoad() {
        
        let name = place["name"].stringValue
        let lonlat = place["lonlat"]["coordinates"].arrayValue

        println("At \(place) \(name) \(lonlat)")
        
        nameLabel.text = name
        latLongLabel.text = "\(lonlat[0]),\(lonlat[1])"
        
    }

}