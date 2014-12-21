//
//  NewBroadcastViewController.swift
//  Hackin.at
//
//  Created by Prateek on 12/17/14.
//  Copyright (c) 2014 Prateek Dayal. All rights reserved.
//

import UIKit

class NewBroadcastViewController: UIViewController, PlacesViewProtocol {
    
    
    var place: AnyObject?
    
    override func viewDidAppear(animated: Bool) {
        
        if place == nil {
            println("There is no place!")
            let vc = self.storyboard?.instantiateViewControllerWithIdentifier("placesViewController") as PlacesViewController;
            vc.delegate = self
            self.presentViewController(vc, animated: true, completion: nil)
        }
        
    }
    
    func placeSelected(place: JSON) {
        println("Hacker is at \(place)")
    }
    
}
