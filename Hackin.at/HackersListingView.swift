//
//  HackersListing.swift
//  Hackin.at
//
//  Created by Prateek on 3/5/15.
//  Copyright (c) 2015 Prateek Dayal. All rights reserved.
//

import UIKit
import PureLayout

class HackersListingView: UIView, UITableViewDelegate, UITableViewDataSource, HackersDataSourceDelegate {
   
    var hackersTableView = UITableView()
    var hackers: Array<Hacker> = []
    var tableRefreshControl:TableRefreshControl!
    var cellStyle: HackerTableCell.Type!
    var currentNavigationController: UINavigationController?
    var backgroundLabel = UILabel()
    var backgroundLabelActive = false
    var emptyTableMessage:String?
    var hackersDataSource: HackersDataSource!
    var pullToRefresh: Bool = false
    
    override init (frame : CGRect) {
        super.init(frame : frame)
    }
    
    convenience init(
        cellStyle: HackerTableCell.Type = HackerTableCell.self,
        pullToRefresh:Bool = false,
        emptyTableMessage: String? = nil,
        hackersDataSource: HackersDataSource){
        self.init(frame:CGRectZero)
        self.cellStyle = cellStyle
        self.emptyTableMessage = emptyTableMessage
        self.hackersDataSource = hackersDataSource
        self.hackersDataSource.delegate = self
        self.pullToRefresh = pullToRefresh
        setupTableViewWiring()
        addSubview(hackersTableView)
        setupTableViewStyle()
        if pullToRefresh { setupAutoRefresh() }
        fetchHackers()
    }
    
    func fetchHackers(){
        hackersDataSource.fetch()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setupTableViewWiring(){
        hackersTableView.delegate = self
        hackersTableView.dataSource = self
    }
    
    func hackersFetched() {
        renderHackers()
        if (pullToRefresh && tableRefreshControl.refreshing) { tableRefreshControl.endRefreshing()}
    }
    
    func setupAutoRefresh(){
        tableRefreshControl = TableRefreshControl.setupForTableViewWithAction(
            tableView: self.hackersTableView,
            target: self,
            action: "fetchHackers"
        )
    }
    
    func refreshHackers(){
        fetchHackers()
    }

    
    func setupTableViewStyle(){
        hackersTableView.estimatedRowHeight = 100
        hackersTableView.rowHeight = UITableViewAutomaticDimension
        hackersTableView.separatorInset = UIEdgeInsetsZero
        hackersTableView.tableFooterView = UIView(frame: CGRectZero)
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
    
    func renderHackers(){
        if (emptyTableMessage != nil){
            if(hackersDataSource.count == 0){
                backgroundLabel.text = emptyTableMessage
                hackersTableView.backgroundView = backgroundLabel
                backgroundLabelActive = true
                updateConstraints()
            }else{
                backgroundLabelActive = false
                hackersTableView.backgroundView = nil
                updateConstraints()
            }
        }
        self.hackersTableView.reloadData()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        println("Hackers \(hackersDataSource.count)")
        return hackersDataSource.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.cellStyle(style: UITableViewCellStyle.Default, reuseIdentifier: "HackerCell")
        let hacker = hackersDataSource.hackers[indexPath.row]
        cell.setupViewData(hacker)
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        println("Did select row!")
        let hacker = hackersDataSource.hackers[indexPath.row]
        let vc = AppScreens.Profile(hacker).vc
        currentNavigationController?.pushViewController(vc, animated: true)
    }
}