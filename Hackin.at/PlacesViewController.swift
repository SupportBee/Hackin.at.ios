//
//  PlacesViewController.swift
//  Hackin.at
//
//  Created by Prateek on 12/18/14.
//  Copyright (c) 2014 Prateek Dayal. All rights reserved.
//


import UIKit
import Alamofire
import SwiftyJSON

protocol PlacesViewProtocol {
    
    func placeSelected(place:JSON)
    
}

class PlacesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var containerView: UIView!
    @IBOutlet weak var placesTableView: UITableView!
    
    var places: Array<JSON> = []
    var delegate: PlacesViewProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.placesTableView.delegate = self
        self.placesTableView.dataSource = self
        self.placesTableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        fetchPlaces()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func fetchPlaces() {
        Hackinat.sharedInstance.fetchPlacesAroundLocation(authKey: authKey, location: currentLocation, success: renderPlaces)
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
        println("You selected the place #\(places[indexPath.row])!")
        self.delegate?.placeSelected(places[indexPath.row])
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}