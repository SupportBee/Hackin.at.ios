//
//  NewBroadcastViewController.swift
//  Hackin.at
//
//  Created by Prateek on 12/17/14.
//  Copyright (c) 2014 Prateek Dayal. All rights reserved.
//

import UIKit
import Alamofire

class NewBroadcastViewController: UIViewController, PlacesViewProtocol {
    
    
    var place: JSON?
    @IBOutlet weak var broadcastMessageTextView: UITextView!
    @IBOutlet weak var currentPlaceLabel: UILabel!
    
    @IBOutlet weak var postBroadcastButton: UIButton!
    
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
        self.place = place
        var placeName = place["name"]
        currentPlaceLabel.text = "You are at \(placeName)"
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func postBroadcast(sender: AnyObject) {
        let parameters = [
            "log": [
                "message": broadcastMessageTextView.text,
                "place_id": self.place!["id"].stringValue,
                "client_id": 1 // Yo! Goodbye Android
            ]
        ]
        println("Ok! I am going to post this broadcast \(parameters)")
        Alamofire.request(.POST, "\(baseDomain)/logs?auth_key=\(authKey)", parameters: parameters)

    }
}
