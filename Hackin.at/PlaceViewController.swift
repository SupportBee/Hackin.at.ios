//
//  PlaceViewController.swift
//  Hackin.at
//
//  Created by Prateek on 1/6/15.
//  Copyright (c) 2015 Prateek Dayal. All rights reserved.
//

import UIKit
import MapKit
import PureLayout

class PlaceViewController: UIViewController {
    
    var place: Place!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var latLongLabel: UILabel!
    
    @IBOutlet weak var mapView: MKMapView!
    
    var name = ""
    
    override func viewDidLoad() {
        name = place!.name
        nameLabel.text = name
        mapView.layer
    }
    
    override func viewDidAppear(animated: Bool) {
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

        
        let annotation = MKPointAnnotation()
        annotation.setCoordinate(coords)
        annotation.title = name
        mapView.addAnnotation(annotation)
    }
    
    override func updateViewConstraints() {
        nameLabel.autoPinToTopLayoutGuideOfViewController(self, withInset: AppTheme.Listing.elementsPadding)
        nameLabel.autoPinEdgeToSuperviewEdge(ALEdge.Left, withInset: AppTheme.HackerListing.paddingLeft)

        // NOTE: Can't style maps using PureLayout. Doing it in IB
        
        //mapView.autoPinEdgeToSuperviewEdge(ALEdge.Left, withInset: AppTheme.HackerListing.paddingLeft)
        //mapView.autoPinEdgeToSuperviewEdge(ALEdge.Right, withInset: AppTheme.HackerListing.paddingLeft)
        //mapView.autoPinEdge(ALEdge.Top, toEdge: ALEdge.Bottom, ofView: nameLabel, withOffset: AppTheme.HackerListing.paddingTop)
        super.updateViewConstraints()
    }

}