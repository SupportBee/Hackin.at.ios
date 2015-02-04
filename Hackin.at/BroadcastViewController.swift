//
//  BroadcastDetails.swift
//  Hackin.at
//
//  Created by Prateek on 1/2/15.
//  Copyright (c) 2015 Prateek Dayal. All rights reserved.
//


import UIKit
import Alamofire
//import SwiftyJSON

class BroadcastViewController: UIViewController {
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var loginLabel: UILabel!
    
    @IBOutlet weak var messageTextView: UITextView!
    @IBOutlet weak var placeLabelButton: UIButton!
    
    var broadcast: Broadcast! = nil
    
    override func viewDidLoad() {
        renderBroadcast()
    }
    
    func renderBroadcast() {
        let hacker = broadcast.hacker.login //["logged_by"]["login"].stringValue
        let avatarURL = broadcast.hacker.avatarURL! //["logged_by"]["avatar_url"].stringValue
        println(avatarURL)
        let message = broadcast.message //["message"].stringValue
        var placeName = ""
        if broadcast.place != nil {
            placeName = broadcast.place!.name //["logged_at"]["place"]["name"].stringValue
        }
        
        loginLabel.text = hacker
        messageTextView.text = message
        println("At \(placeName)")
        placeLabelButton.setTitle(placeName, forState: UIControlState.Normal)
        
        Alamofire.request(.GET, avatarURL)
            .response{ (_, _, data, _) in
                self.profileImageView.image = UIImage(data: (data as NSData) )
        }
    }
    
    @IBAction func placeLabelButtonClicked(sender: AnyObject) {
        var newPlacesStoryBoard = UIStoryboard(name: "Places", bundle: nil)
        let vc = newPlacesStoryBoard.instantiateViewControllerWithIdentifier("placeViewController") as PlaceViewController;
        vc.place = broadcast.place! //["logged_at"]["place"]
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
