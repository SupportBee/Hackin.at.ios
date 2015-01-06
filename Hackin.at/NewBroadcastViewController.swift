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
    
    @IBOutlet weak var postToTwitterSwitch: UISwitch!
    
    override func viewDidAppear(animated: Bool) {
        
        if place == nil {
            println("There is no place!")
            var placesStoryboard = UIStoryboard(name: "Places", bundle: nil)
            let vc = placesStoryboard.instantiateViewControllerWithIdentifier("placesViewController") as PlacesViewController;
            vc.delegate = self
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    
    func placeSelected(place: JSON) {
        println("Hacker is at \(place)")
        self.place = place
        var placeName = place["name"]
        currentPlaceLabel.text = "You are at \(placeName)"
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    @IBAction func postBroadcast(sender: AnyObject) {
        let postToTwitter = postToTwitterSwitch.on ? "true" : "false"
        let parameters = [
            "log": [
                "message": broadcastMessageTextView.text,
                "place_id": self.place!["id"].stringValue,
                "client_id": 1,
                "twitter_cross_post": postToTwitter
            ]
        ]
        println("Ok! I am going to post this broadcast \(parameters)")
        Alamofire.request(.POST, "\(baseDomain)/logs?auth_key=\(authKey)", parameters: parameters)

    }
}
