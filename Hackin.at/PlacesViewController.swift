//
//  PlacesViewController.swift
//  Hackin.at
//
//  Created by Prateek on 12/18/14.
//  Copyright (c) 2014 Prateek Dayal. All rights reserved.
//


import UIKit
import Alamofire

class PlacesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var containerView: UIView!
    @IBOutlet weak var placesTableView: UITableView!
    
    var places: Array<JSON> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.placesTableView.delegate = self
        self.placesTableView.dataSource = self
        self.placesTableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        fetchPlaces()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func fetchPlaces() {
        
        var placesURL = "\(baseDomain)/places?auth_key=\(authKey)&ll=\(currentLocation.latitude),\(currentLocation.longitude)"
        println("Let's get the places around")
        
        Alamofire.request(.GET, placesURL)
            .responseJSON { (_, _, JSON, _) in
                self.renderPlaces(JSON)
        }
        
    }
    
    func renderPlaces(placesJSON: AnyObject!) {
        places = JSON(placesJSON)["places"].arrayValue
        println(places)
        placesTableView.reloadData()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        println("Number of rows \(self.places.count)")
        return self.places.count;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "cell")
        let placeName = places[indexPath.row]["name"].stringValue
        cell.textLabel?.text = placeName
        println("At \(indexPath.row) \(placeName)")
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        println("You selected cell #\(indexPath.row)!")
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}