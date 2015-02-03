//
//  BroadcastDetails.swift
//  Hackin.at
//
//  Created by Prateek on 1/2/15.
//  Copyright (c) 2015 Prateek Dayal. All rights reserved.
//


import UIKit
import Alamofire
import SwiftyJSON

class BroadcastViewController: UIViewController {
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var loginLabel: UILabel!
    
    @IBOutlet weak var messageTextView: UITextView!
    @IBOutlet weak var placeLabelButton: UIButton!
    
    var broadcast: JSON! = nil
    
    override func viewDidLoad() {
        setupStyles()
        renderBroadcast()
    }
    
    
    func setupStyles(){
        self.profileImageView.layer.cornerRadius = self.profileImageView.frame.size.width / 2;
        self.profileImageView.clipsToBounds = true;
        
        self.messageTextView.backgroundColor = UIColor(red: 255.0/255.0, green: 248.0/255.0, blue: 248.0/255.0, alpha: 1)
    }
    
    func renderBroadcast() {
        let hacker = broadcast["logged_by"]["login"].stringValue
        let avatarURL = broadcast["logged_by"]["avatar_url"].stringValue
        let message = broadcast["message"].stringValue
        let placeName = broadcast["logged_at"]["place"]["name"].stringValue
        
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
        vc.place = broadcast["logged_at"]["place"]
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
