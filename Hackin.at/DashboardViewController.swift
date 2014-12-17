//
//  DashboardViewController.swift
//  Hackin.at
//
//  Created by Prateek on 12/17/14.
//  Copyright (c) 2014 Prateek Dayal. All rights reserved.
//

//
//  DashboardViewController.swift
//  Github Auth
//
//  Created by Prateek on 11/6/14.
//  Copyright (c) 2014 Prateek. All rights reserved.
//

import UIKit

class DashboardViewController: UIViewController {
    
    @IBOutlet weak var welcomeLabel: UILabel!
    
    var login: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        login = NSUserDefaults.standardUserDefaults().objectForKey("login") as? String
        if login != nil {
            welcomeLabel.text = "Welcome to Hackin.at \(login)"
        }
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(animated: Bool) {
        if login == nil {
            let vc = self.storyboard?.instantiateViewControllerWithIdentifier("loginViewController") as LoginViewController;
            self.presentViewController(vc, animated: true, completion: nil)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
}