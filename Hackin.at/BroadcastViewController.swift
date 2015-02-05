//
//  BroadcastDetails.swift
//  Hackin.at
//
//  Created by Prateek on 1/2/15.
//  Copyright (c) 2015 Prateek Dayal. All rights reserved.
//


import UIKit

class BroadcastViewController: UIViewController {
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var loginLabel: UILabel!
    
    @IBOutlet weak var messageTextView: UITextView!
    @IBOutlet weak var placeLabelButton: UIButton!
    
    var broadcast: Broadcast! = nil
    
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

        let hacker = broadcast.hacker
        let message = broadcast.message
        var placeName = ""
        if broadcast.place != nil {
            placeName = broadcast.place!.name
        }
        
        loginLabel.text = hacker.login
        messageTextView.text = message
        println("At \(placeName)")
        placeLabelButton.setTitle(placeName, forState: UIControlState.Normal)
        hacker.fetchAvatarImage(success: {
            (image: UIImage) in
                self.profileImageView.image = image
        })

    }
    
    @IBAction func placeLabelButtonClicked(sender: AnyObject) {
        var newPlacesStoryBoard = UIStoryboard(name: "Places", bundle: nil)
        let vc = newPlacesStoryBoard.instantiateViewControllerWithIdentifier("placeViewController") as PlaceViewController;
        vc.place = broadcast.place! 
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
