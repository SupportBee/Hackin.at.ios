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
import Alamofire

//let baseDomain = "http://lvh.me:3000"
let baseDomain = "https://hackin.at"

class LoginViewController: UIViewController, WKNavigationDelegate {
    
    @IBOutlet var containerView: UIView!
    var webView: WKWebView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func loginButtonPressed(sender: UIButton) {
        println("So you want to login with Github?")
        webView = WKWebView()
        webView?.navigationDelegate = self
        view = self.webView!
        var url = NSURL(string:"\(baseDomain)/auth/github?api=true")
        var req = NSURLRequest(URL:url!)
        self.webView!.loadRequest(req)
    }
    
    
    
    func webView(webView: WKWebView!, didFinishNavigation navigation: WKNavigation!) {
        // If the URL has afterauth, extract auth_token and other info from it
        let url: NSURL = webView.URL!
        println("Finished navigating to url \(url)")
        if url.absoluteString?.rangeOfString("afterauth") != nil{
            let queryString = url.query
            var keys = [String: String]()
            queryString?.componentsSeparatedByString("&").map {
                (keyValuePair: String) -> Void in
                let keyValue = keyValuePair.componentsSeparatedByString("=")
                let key = keyValue[0]
                let value = keyValue[1]
                keys[key] = value
                
                // Replace this with something more secure later
                NSUserDefaults.standardUserDefaults().setObject(value, forKey: key)
            }
            let secondViewController = self.storyboard?.instantiateViewControllerWithIdentifier("DashboardViewController") as DashboardViewController
            self.presentViewController(secondViewController, animated: true, completion: nil)
            
        }
        
    }
    
}