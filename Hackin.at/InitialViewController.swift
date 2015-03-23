//
//  InitialViewController.swift
//  Hackin.at
//
//  Created by Prateek on 12/23/14.
//  Copyright (c) 2014 Prateek Dayal. All rights reserved.
//

import UIKit
import PureLayout

// All Globals here for now
class InitialViewController: UIViewController, LoginViewDelegate {
    
    @IBOutlet weak var logoImageView: UIImageView!
    // Location setup
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(animated: Bool) {
        if CurrentHacker.doesExist() {
            postLoginInit()
        }else{
            showLoginView()
        }
    }
    
    func showLoginView(){
        let vc = self.storyboard?.instantiateViewControllerWithIdentifier("loginViewController") as LoginViewController;
        vc.delegate = self
        self.presentViewController(vc, animated: true, completion: nil)
    }
 
    func hackerLoggedIn() {
        self.dismissViewControllerAnimated(true, completion: nil)
        
        trackLogin()
        Hackinat.sharedInstance.resetAlamofireManager()
        setHackerDeviceToken()
        
        postLoginInit()
    }
    
    func postLoginInit(){
        launchApp()
    }
    
    func trackLogin(){
        MixpanelHelper().identifyCurrentUser()
        MixpanelHelper().trackLogin()
    }
    
    func launchApp() {
        let vc = self.storyboard?.instantiateViewControllerWithIdentifier("mainViewController") as MainViewController;
        self.presentViewController(vc, animated: true, completion: nil)
    }
    
    override func updateViewConstraints() {
        logoImageView.autoAlignAxisToSuperviewAxis(ALAxis.Horizontal)
        logoImageView.autoAlignAxisToSuperviewAxis(ALAxis.Vertical)
        super.updateViewConstraints()
    }
 
    private func setHackerDeviceToken(){
        let deviceAPNSToken = NSUserDefaults.standardUserDefaults().objectForKey("apns_device_token") as? String
        if(deviceAPNSToken == nil){ return }
        
        if(CurrentHacker.apnsDeviceToken == nil){
            CurrentHacker.hacker()?.setDeviceToken(deviceAPNSToken!)
        }
    }
    
}
