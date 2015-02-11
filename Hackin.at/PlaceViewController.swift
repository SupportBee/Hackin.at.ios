//
//  PlaceViewController.swift
//  Hackin.at
//
//  Created by Prateek on 1/6/15.
//  Copyright (c) 2015 Prateek Dayal. All rights reserved.
//

import UIKit
import MapKit

class PlaceViewController: UIViewController {
    
    var place: Place!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var latLongLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        
        let name = place!.name
        let location = place!.location
        let lat = (location.latitude as NSString).doubleValue
        let lng = (location.longitude as NSString).doubleValue
        
        let coords = CLLocationCoordinate2D(
            latitude: lat,
            longitude: lng
        )
        
        let span = MKCoordinateSpanMake(0.05, 0.05)
        let region = MKCoordinateRegion(center: coords, span: span)
        mapView.setRegion(region, animated: true)

        nameLabel.text = name
        latLongLabel.text = "\(location.longitude),\(location.latitude)"
        
        let annotation = MKPointAnnotation()
        annotation.setCoordinate(coords)
        annotation.title = name
        mapView.addAnnotation(annotation)

    }

}