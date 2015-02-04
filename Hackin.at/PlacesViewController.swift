//
//  PlacesViewController.swift
//  Hackin.at
//
//  Created by Prateek on 12/18/14.
//  Copyright (c) 2014 Prateek Dayal. All rights reserved.
//


import UIKit

protocol PlacesViewProtocol {
    
    func placeSelected(place:Place)
    
}

class PlacesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var containerView: UIView!
    @IBOutlet weak var placesTableView: UITableView!
    
    var places: Array<Place> = []
    var delegate: PlacesViewProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.placesTableView.delegate = self
        self.placesTableView.dataSource = self
        self.placesTableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        fetchPlaces()
    }
    
    func fetchPlaces() {
        Place.fetchPlacesAround(success: renderPlaces)
    }
    
    func renderPlaces(places: [Place]) {
        println(places)

        self.places = places
        placesTableView.reloadData()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        println("Number of rows \(self.places.count)")
        return self.places.count;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "cell")
        let placeName = places[indexPath.row].name
        cell.textLabel?.text = placeName
        println("At \(indexPath.row) \(placeName)")
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        println("You selected the place #\(places[indexPath.row].name)!")
        self.delegate?.placeSelected(places[indexPath.row])
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}