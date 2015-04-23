//
//  ProfileViewController.swift
//  Github Auth
//
//  Created by Prateek on 11/10/14.
//  Copyright (c) 2014 Prateek. All rights reserved.
//

import UIKit
import Alamofire
import PureLayout

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var loginLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var companyLabel: UILabel!
    
    @IBOutlet weak var basicInfoView: UIView!
    @IBOutlet weak var metaInfoView: UIView!
    @IBOutlet weak var tableHeaderView: UIView!
    
    @IBOutlet weak var reposCountLabel: UILabel!
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var stickersLabel: UILabel!

    @IBOutlet weak var friendsLabel: UILabel!
    
    var hacker:Hacker!
    var friends: [Hacker]!
    var friendsListing: HackersListingView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTable()
        clearPlaceholderLabels()
        setupStyles()
        setupLoggedInUser()
        populateBasicInfo()
        renderUserDetails()
        setupTitle()
    }
    
    func setupFriendshipButton(){
        if (hacker.login != CurrentHacker.hacker()?.login) {
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: FriendshipButtonSet(toBeFriend: hacker))
        }
    }
    
    func setupTable(){
        friendsListing = HackersListingView(cellStyle: HackerTableCell.FullView.self,
            hackersDataSource: FriendsofHackerDataSource(hacker: hacker))
        friendsListing.hackersTableView.tableHeaderView = tableHeaderView
        friendsListing.currentNavigationController = navigationController
        view.addSubview(friendsListing)
    }
    
    func setupTitle(){
        var title = ""
        if (hacker.login == CurrentHacker.hacker()?.login) {
            title = "Me"
        }else{
            title = "@\(hacker.login)"
        }
        self.title = title
    }
    
    func clearPlaceholderLabels(){
        stickersLabel.text = ""
        nameLabel.text = "Fetching more info ..."
        reposCountLabel.text = ""
        friendsLabel.text = ""
        companyLabel.text = ""
    }
    
    @IBAction func followButtonPressed(sender: AnyObject) {
    }
    
    func setupLoggedInUser(){
        if self.hacker == nil {
            self.hacker = CurrentHacker.hacker()!
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func renderUserDetails(){
        if(hacker.hasFullProfile()){
            renderFullProfile()
        }else{
            hacker.fetchFullProfile(success: renderFullProfile)
        }
    }

    func setupStyles(){
        profileImage.layer.cornerRadius = self.profileImage.frame.size.width/2;
        profileImage.clipsToBounds = true;
        basicInfoView.backgroundColor = AppColors.profileBgColor
        metaInfoView.backgroundColor = AppColors.profileBgColor
    }
    
    override func updateViewConstraints() {
        
        let inset = AppTheme.Listing.elementsPadding/2.0
        friendsListing.autoPinEdgesToSuperviewMargins()
        tableHeaderView.autoPinEdgesToSuperviewMarginsExcludingEdge(ALEdge.Bottom)
        basicInfoView.autoPinEdgeToSuperviewEdge(ALEdge.Top)
        basicInfoView.autoPinEdgeToSuperviewEdge(ALEdge.Left)
        
        // IMP: Pinning the right edge would make the superview shrink 
        // if basicInfoView is not wide enough
        //basicInfoView.autoPinEdgesToSuperviewEdgesWithInsets(UIEdgeInsetsMake(inset, inset, 0, inset), excludingEdge: ALEdge.Bottom)
        
        metaInfoView.autoPinEdgeToSuperviewEdge(ALEdge.Left)
        
        profileImage.autoPinEdgeToSuperviewEdge(ALEdge.Left, withInset: 0)
        profileImage.autoPinEdgeToSuperviewEdge(ALEdge.Top, withInset: 0)
        profileImage.autoPinEdgeToSuperviewEdge(ALEdge.Bottom, withInset: 0, relation: NSLayoutRelation.GreaterThanOrEqual)
        
        loginLabel.autoPinEdge(ALEdge.Left, toEdge: ALEdge.Right,
            ofView: profileImage, withOffset: AppTheme.Listing.elementsPadding)
        loginLabel.autoPinEdge(ALEdge.Top, toEdge: ALEdge.Top, ofView: profileImage)
        
        nameLabel.autoPinEdge(ALEdge.Left, toEdge: ALEdge.Right, ofView: profileImage, withOffset: AppTheme.Listing.elementsPadding)
        nameLabel.autoPinEdge(ALEdge.Top, toEdge: ALEdge.Bottom, ofView: loginLabel, withOffset: AppTheme.Listing.elementsPadding)

        companyLabel.autoPinEdge(ALEdge.Left, toEdge: ALEdge.Right, ofView: profileImage, withOffset: AppTheme.Listing.elementsPadding)
        companyLabel.autoPinEdge(ALEdge.Top, toEdge: ALEdge.Bottom, ofView: nameLabel, withOffset: AppTheme.Listing.elementsPadding)
        companyLabel.autoPinEdgeToSuperviewEdge(ALEdge.Bottom, withInset: 0, relation: NSLayoutRelation.GreaterThanOrEqual)
        companyLabel.autoPinEdgeToSuperviewEdge(ALEdge.Right, withInset: 0, relation: NSLayoutRelation.GreaterThanOrEqual)
        
        metaInfoView.autoPinEdge(ALEdge.Top, toEdge: ALEdge.Bottom, ofView: basicInfoView, withOffset: AppTheme.Listing.elementsPadding)
        
        reposCountLabel.autoPinEdgeToSuperviewEdge(ALEdge.Top)
        reposCountLabel.autoPinEdgeToSuperviewEdge(ALEdge.Left)
        reposCountLabel.autoPinEdgeToSuperviewEdge(ALEdge.Bottom, withInset: 0, relation: NSLayoutRelation.GreaterThanOrEqual)

        stickersLabel.autoAlignAxis(ALAxis.Horizontal, toSameAxisOfView: reposCountLabel)
        stickersLabel.autoPinEdge(ALEdge.Right, toEdge: ALEdge.Right, ofView: friendsListing)
        stickersLabel.autoPinEdgeToSuperviewEdge(ALEdge.Bottom, withInset: 0, relation: NSLayoutRelation.GreaterThanOrEqual)
        
        friendsLabel.autoPinEdge(ALEdge.Left, toEdge: ALEdge.Left, ofView: metaInfoView)
        friendsLabel.autoPinEdge(ALEdge.Top, toEdge: ALEdge.Bottom, ofView: metaInfoView, withOffset: AppTheme.Listing.elementsPadding)
        
        // Without this the header height will be 0
        friendsLabel.autoPinEdgeToSuperviewEdge(ALEdge.Bottom, withInset: AppTheme.Listing.elementsPadding, relation: NSLayoutRelation.GreaterThanOrEqual)
        
        super.updateViewConstraints()
    }
    
    func renderFullProfile(){
        // Now that we have the data!
        setupFriendshipButton()
        var userDetails = hacker.userDetails!

        var avatarURL = userDetails["avatar_url"].string
        
        // Personal Info
        nameLabel.text = userDetails["name"].string
        companyLabel.text = userDetails["company"].string
        friendsLabel.text = "Friends"
        
        // Counts
        var reposCount = userDetails["github_repos"].int
        
        
        reposCountLabel.text = "\(reposCount!) Public Repos"
        
        stickersLabel.font = UIFont(name: "pictonic", size: 18)
        stickersLabel.text = hacker.stickerCodes()
    }
    
    func populateBasicInfo(){
        Helpers.showProfileImage(hacker, imageView: profileImage, size: CGFloat(128.0))
        loginLabel.text = "@\(hacker.login)"
    }
    
}