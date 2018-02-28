//
//  Address.swift
//  Easy
//
//  Created by Lucas Antonelli Novaes on 25/02/2018.
//  Copyright © 2018 Lucas Novaes. All rights reserved.
//

import Foundation
import GoogleMaps
import GooglePlaces

struct Address{
    
    var street: String
    var city: String
    var neighborhood: String
    var coordinate: CLLocationCoordinate2D?
    
    init(address: GMSAddress){
        self.street = address.thoroughfare ?? "Unamed Road"
        self.city = address.locality ?? ""
        self.neighborhood = address.subLocality ?? ""
        self.coordinate = address.coordinate
    }
    
}


