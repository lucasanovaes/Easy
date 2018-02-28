//
//  TaxiMarker.swift
//  Easy
//
//  Created by iCasei Site on 23/02/2018.
//  Copyright © 2018 Lucas Novaes. All rights reserved.
//

import Foundation
import GoogleMaps

final class TaxiMarker: GMSMarker{
    
    var location: CLLocation
    
    init(taxi: Taxi){
        location = taxi.location
        
        super.init()
        position = CLLocationCoordinate2D(latitude: taxi.lat, longitude: taxi.lng)
        title = taxi.driver_name
        snippet = taxi.driver_car
        icon = #imageLiteral(resourceName: "icon_marker_taxi")
        groundAnchor = CGPoint(x: 0.5, y: 1)
        appearAnimation = .pop
    }
}
