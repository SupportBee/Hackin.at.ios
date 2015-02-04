//
//  Place.swift
//  Hackin.at
//
//  Created by Avinasha Shastry on 04/02/15.
//  Copyright (c) 2015 Prateek Dayal. All rights reserved.
//

import SwiftyJSON

class Place: NSObject {
    struct Location {
        var latitude:String
        var longitude:String
    }
    
    let name:String
    let id:String
    var location:Location
    
    init(id: String, name: String, latitude: String, longitude: String){
        self.id = id
        self.name = name
        self.location = Location(latitude: latitude, longitude: longitude)
    }
    
    convenience init(json: JSON){
        let name = json["name"].stringValue
        let lonlat = json["lonlat"]["coordinates"].arrayValue
        let longitude = lonlat[0].stringValue
        let latitude = lonlat[1].stringValue
        let id = json["id"].stringValue
        self.init(id: id, name: name, latitude: latitude, longitude: longitude)
    }
    
    class func fetchPlacesAround(#success: ([Place]) -> ()){
        
        func onFetch(result: AnyObject){
            var placesJSON = JSON(result)["places"].arrayValue
            var places: Array<Place> = []
            
            places = placesJSON.map({
                (place) -> Place in
                return Place(json: place)
            })
            
            success(places)
        }
        
        Hackinat.sharedInstance.fetchPlacesAroundLocation(authKey: CurrentHacker.authKey!, location: currentLocation, success: onFetch)
    }
}
