//
//  LoginViewController.swift
//  Hackin.at
//
//  Created by Prateek on 12/17/14.
//  Copyright (c) 2014 Prateek Dayal. All rights reserved.
//
//
//  LoginViewController.swift
//  Github Auth
//
//  Created by Prateek on 11/3/14.
//  Copyright (c) 2014 Prateek. All rights reserved.
//

import UIKit
import WebKit
import PureLayout

protocol LoginViewDelegate {
    
    func hackerLoggedIn()
    
}

class LoginViewController: UIViewController, WKNavigationDelegate {
    
    @IBOutlet var containerView: UIView!
    var webView: WKWebView?
    var delegate: LoginViewDelegate?
    
    @IBOutlet weak var loginButton: UIButton!
    
    var loginViewLoaded = false
    var webViewDisplayed = false
    var loginButtonPressed = false

    @IBOutlet weak var loginBg: UIImageView!
    
    let accessNotice = "We request read-only access to your public information"
    let loadingNotice = "Contacting Mothership. Please stand by ..."
    
    @IBOutlet weak var noticeText: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAccessNotice()
        setupWebView()
    }
    
    
    func setupAccessNotice(){
        noticeText.text = accessNotice
        noticeText.backgroundColor = UIColor.clearColor()
        noticeText.textColor = AppColors.loginNotice
        
        //http://stackoverflow.com/questions/16868117/uitextview-that-expands-to-text-using-auto-layout
        noticeText.scrollEnabled = false
        
        //http://stackoverflow.com/questions/19049917/uitextview-font-is-being-reset-after-settext
        noticeText.selectable = true
    }
    
    override func updateViewConstraints() {
        loginBg.autoPinEdgesToSuperviewMargins()
        loginButton.autoAlignAxis(ALAxis.Horizontal, toSameAxisOfView: loginBg)
        loginButton.autoAlignAxis(ALAxis.Vertical, toSameAxisOfView: loginBg)
        noticeText.autoAlignAxis(ALAxis.Vertical, toSameAxisOfView: loginButton)
        noticeText.autoPinEdge(ALEdge.Top, toEdge: ALEdge.Bottom, ofView: loginButton, withOffset: AppTheme.Listing.elementsPadding)
        super.updateViewConstraints()
    }
    
    func setupWebView(){
        webView = WKWebView()
        webView?.frame = CGRect(x: 0,y: 0,width: 0,height: 0)
        webView?.navigationDelegate = self
        
        self.view.addSubview(self.webView!)
        
        var url = NSURL(string: Hackinat.sharedInstance.githhubAuthURL)
        var req = NSURLRequest(URL:url!)
        self.webView!.loadRequest(req)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func loginButtonPressed(sender: UIButton) {
        loginButtonPressed = true
        if loginViewLoaded {
            showWebView()
        }else{
            loginButton.hidden = true
            noticeText.text = loadingNotice
        }
    }
    
    func showWebView(){
        webViewDisplayed = true
        self.view = self.webView!
    }
    
    
    
    func webView(webView: WKWebView, didFinishNavigation navigation: WKNavigation!) {
        // If the URL has afterauth, extract auth_token and other info from it
        let url: NSURL = webView.URL!
        loginViewLoaded = true
        if (loginButtonPressed && !webViewDisplayed){
            showWebView()
            loginButton.hidden = false
            noticeText.text = accessNotice
        }
        if url.absoluteString?.rangeOfString("afterauth") != nil{
            let queryString = url.query
            
            queryString?.componentsSeparatedByString("&").map {
                (keyValuePair: String) -> Void in
                let keyValue = keyValuePair.componentsSeparatedByString("=")
                let key = keyValue[0]
                let value = keyValue[1]
                
                if(key == "login"){ CurrentHacker.login = value }
                if(key == "auth_key"){
                    println("Setting Auth Key")
                    CurrentHacker.authKey = value
                }
                
                self.delegate?.hackerLoggedIn()
            }
            
        }
        
    }
    
}