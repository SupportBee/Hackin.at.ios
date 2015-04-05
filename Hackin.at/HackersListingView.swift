//
//  HackersListing.swift
//  Hackin.at
//
//  Created by Prateek on 3/5/15.
//  Copyright (c) 2015 Prateek Dayal. All rights reserved.
//

import UIKit
import PureLayout

class HackersListingView: UIView, UITableViewDelegate, UITableViewDataSource {
   
    var hackersTableView = UITableView()
    var hackers: Array<Hacker> = []
    var tableRefreshControl:TableRefreshControl!
    var cellStyle: HackerTableCell.Type!
    var currentNavigationController: UINavigationController?
    var backgroundLabel = UILabel()
    var backgroundLabelActive = false
    var emptyTableMessage:String?
    
    override init (frame : CGRect) {
        super.init(frame : frame)
    }
    
    convenience init(
        cellStyle: HackerTableCell.Type = HackerTableCell.self,
        pullToRefresh:Bool = true,
        emptyTableMessage: String? = nil){
        self.init(frame:CGRectZero)
        self.cellStyle = cellStyle
        self.emptyTableMessage = emptyTableMessage
        setupTableViewWiring()
        addSubview(hackersTableView)
        setupTableViewStyle()
        setupAutoRefresh()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setupTableViewWiring(){
        hackersTableView.delegate = self
        hackersTableView.dataSource = self
    }
    
    func setupAutoRefresh(){
        tableRefreshControl = TableRefreshControl.setupForTableViewWithAction(
            tableView: self.hackersTableView,
            target: self,
            action: "refreshHackers"
        )
    }
    
    func setupTableViewStyle(){
        hackersTableView.estimatedRowHeight = 100
        hackersTableView.rowHeight = UITableViewAutomaticDimension
        hackersTableView.separatorInset = UIEdgeInsetsZero
        backgroundLabel.numberOfLines = 0
        backgroundLabel.textAlignment = NSTextAlignment.Center
    }
    
    
    override func updateConstraints() {
        hackersTableView.autoPinEdgesToSuperviewEdgesWithInsets( UIEdgeInsetsZero)
        if(backgroundLabelActive){
            backgroundLabel.autoAlignAxis(ALAxis.Vertical, toSameAxisOfView: hackersTableView)
            backgroundLabel.autoAlignAxis(ALAxis.Horizontal, toSameAxisOfView: hackersTableView)
        }
        super.updateConstraints()
    }
    
    func refreshHackers(){
        func onFetch(hackers:[Hacker]){
            renderHackers(hackers)
            self.tableRefreshControl.endRefreshing()
        }
        CurrentHacker().friends(success: onFetch)
    }
    
    func fetchFriends(){
        CurrentHacker().friends(success: renderHackers)
    }
    
    func renderHackers(hackers:[Hacker]){
        if (emptyTableMessage != nil){
            if(hackers.count == 0){
                backgroundLabel.text = emptyTableMessage
                hackersTableView.backgroundView = backgroundLabel
                backgroundLabelActive = true
                updateConstraints()
            }else{
                hackersTableView.backgroundView = nil
                updateConstraints()
            }
        }
        self.hackers = hackers
        self.hackersTableView.reloadData()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        println("total \(hackers.count)")
        return hackers.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.cellStyle(style: UITableViewCellStyle.Default, reuseIdentifier: "HackerCell")
        let hacker = self.hackers[indexPath.row]
        println("Rendering \(hacker.login)")
        cell.setupViewData(hacker)
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let hacker = self.hackers[indexPath.row]
        let vc = AppScreens.Profile(hacker).vc
        currentNavigationController?.pushViewController(vc, animated: true)
    }
}