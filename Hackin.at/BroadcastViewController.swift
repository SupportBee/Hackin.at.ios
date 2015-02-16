//
//  BroadcastDetails.swift
//  Hackin.at
//
//  Created by Prateek on 1/2/15.
//  Copyright (c) 2015 Prateek Dayal. All rights reserved.
//


import UIKit
import PureLayout

class BroadcastViewController: UIViewController {
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var loginLabel: UILabel!
    @IBOutlet weak var stickersLabel: UILabel!
    
    @IBOutlet weak var messageTextView: UITextView!
    @IBOutlet weak var placeLabelButton: UIButton!
    @IBOutlet weak var whenLabel: UILabel!
    
    var broadcast: Broadcast! = nil
    
    override func viewDidLoad() {
        setupStyles()
        renderBroadcast()
    }
    
    
    func setupStyles(){
        self.profileImageView.layer.cornerRadius = self.profileImageView.frame.size.width / 2;
        self.profileImageView.clipsToBounds = true;
        
        self.messageTextView.backgroundColor = AppColors.textBackground
    }
    
    func renderBroadcast() {

        let hacker = broadcast.hacker
        let message = broadcast.message
        var placeName = ""
        if broadcast.place != nil {
            placeName = broadcast.place!.name
        }
        
        loginLabel.text = "@\(hacker.login)"
        nameLabel.text = hacker.name
        messageTextView.text = message
        stickersLabel.font = UIFont(name: "pictonic", size: 16)
        stickersLabel.text = hacker.stickerCodes()
        
        let timeAgoDate = broadcast.created_at! 
        whenLabel.text = timeAgoDate.formattedDateWithFormat("MM/DD/YY hh:mm a")
        
        nameLabel.sizeToFit()
        loginLabel.sizeToFit()
        stickersLabel.sizeToFit()
        
        
        placeLabelButton.setTitle(placeName, forState: UIControlState.Normal)
        hacker.fetchAvatarImage(success: {
            (image: UIImage) in
                self.profileImageView.image = image
        })

    }
    
    override func updateViewConstraints() {
        profileImageView.autoPinEdgeToSuperviewEdge(ALEdge.Left,
            withInset: AppTheme.HackerListing.paddingLeft)
        profileImageView.autoPinEdgeToSuperviewEdge(ALEdge.Top,
            withInset: AppTheme.HackerListing.paddingTop)
        
        loginLabel.autoPinEdge(ALEdge.Left, toEdge: ALEdge.Right, ofView: profileImageView,
            withOffset: AppTheme.Listing.elementsPadding)
        loginLabel.autoPinEdgeToSuperviewEdge(ALEdge.Top,
            withInset: AppTheme.HackerListing.paddingTop)
        
        
        nameLabel.autoPinEdge(ALEdge.Left, toEdge: ALEdge.Right, ofView: loginLabel, withOffset: AppTheme.Listing.elementsPadding)
        
        nameLabel.autoAlignAxis(ALAxis.Horizontal, toSameAxisOfView: loginLabel)
        
        stickersLabel.autoPinEdge(ALEdge.Left, toEdge: ALEdge.Right, ofView: profileImageView, withOffset: AppTheme.Listing.elementsPadding)
        stickersLabel.autoPinEdge(ALEdge.Top, toEdge: ALEdge.Bottom, ofView: loginLabel, withOffset: AppTheme.Listing.elementsPadding)
        
        // messageTextView should be un-scrollable for this to work
        messageTextView.autoPinEdge(ALEdge.Top, toEdge: ALEdge.Bottom, ofView: stickersLabel, withOffset: 2*AppTheme.Listing.elementsPadding)
        messageTextView.autoPinEdgeToSuperviewEdge(ALEdge.Left, withInset: AppTheme.HackerListing.paddingLeft)
        messageTextView.autoPinEdgeToSuperviewEdge(ALEdge.Right, withInset: AppTheme.HackerListing.paddingRight)
        
        placeLabelButton.autoPinEdge(ALEdge.Top, toEdge: ALEdge.Bottom, ofView: messageTextView, withOffset: AppTheme.Listing.elementsPadding)
        placeLabelButton.autoPinEdgeToSuperviewEdge(ALEdge.Left,
            withInset: AppTheme.HackerListing.paddingLeft)
        
        whenLabel.autoAlignAxis(ALAxis.Baseline, toSameAxisOfView: placeLabelButton)
        whenLabel.autoPinEdgeToSuperviewEdge(ALEdge.Right,
            withInset: AppTheme.HackerListing.paddingLeft)
        
        super.updateViewConstraints()
        
    }
    
    @IBAction func placeLabelButtonClicked(sender: AnyObject) {
        var newPlacesStoryBoard = UIStoryboard(name: "Places", bundle: nil)
        let vc = newPlacesStoryBoard.instantiateViewControllerWithIdentifier("placeViewController") as PlaceViewController;
        vc.place = broadcast.place! 
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
