//
//  HackersViewController.swift
//  Hackin.at
//
//  Created by Avinasha Shastry on 06/02/15.
//  Copyright (c) 2015 Prateek Dayal. All rights reserved.
//

import UIKit

class HackersViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var hackersTableView: UITableView!
    var hackers: Array<Hacker> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBarStyle()
        self.hackersTableView.delegate = self
        self.hackersTableView.dataSource = self
        self.hackersTableView.registerNib(UINib(nibName: "HackerTableViewCell", bundle: nil), forCellReuseIdentifier: "HackerCell")
        fetchNearbyHackers()
    }
    
    func setupNavigationBarStyle(){
        self.navigationController?.navigationBar.barStyle = UIBarStyle.Black
        self.navigationController?.navigationBar.translucent = false
        self.navigationController?.navigationBar.barTintColor = AppColors.barTint
    }
    
    func setupTableViewStyle(){
        self.hackersTableView.estimatedRowHeight = 100
        self.hackersTableView.rowHeight = UITableViewAutomaticDimension
        self.hackersTableView.separatorInset = UIEdgeInsetsZero
    }
    
    override func updateViewConstraints() {
        self.hackersTableView.autoPinToTopLayoutGuideOfViewController(self, withInset: 0)
        self.hackersTableView.autoPinToBottomLayoutGuideOfViewController(self, withInset: 0)
        self.hackersTableView.autoPinEdgeToSuperviewEdge(ALEdge.Right)
        self.hackersTableView.autoPinEdgeToSuperviewEdge(ALEdge.Left)
        super.updateViewConstraints()
    }
    
    func fetchNearbyHackers(){
        Hacker.fetchNearbyHackers(success: renderHackers)
    }
    
    func renderHackers(hackers:[Hacker]){
        self.hackers = hackers
        self.hackersTableView.reloadData()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return hackers.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("HackerCell", forIndexPath: indexPath) as HackerTableViewCell
        
        let hacker = self.hackers[indexPath.row]
        let login = hacker.login
        let name = "Name"
        let location = "Wherever"
        let stickers = hacker.stickerCodes()
        
        cell.loginLabel.text = login
        cell.nameLabel.text = name
        cell.whereLabel.text = location
        cell.stickersLabel.font = UIFont(name: "pictonic", size: 32)
        cell.stickersLabel.text = stickers
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let hacker = self.hackers[indexPath.row]
        let vc = self.storyboard?.instantiateViewControllerWithIdentifier("profileViewController") as ProfileViewController
        vc.hacker = hacker
        self.navigationController?.pushViewController(vc, animated: true)
    }

}
