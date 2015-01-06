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
    
    var place: JSON?
    
    override func viewDidLoad() {
        println("At \(place)")
    }

}