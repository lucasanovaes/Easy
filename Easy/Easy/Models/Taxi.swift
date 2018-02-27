//
//  Taxi.swift
//  Easy
//
//  Created by Lucas Antonelli Novaes on 26/02/2018.
//  Copyright © 2018 Lucas Novaes. All rights reserved.
//

import Foundation
import CoreLocation

struct Taxi{
    
    var lat: Double
    var lng: Double
    var driver_name: String
    var driver_car: String
    
    init(json: [String : AnyObject]){
        self.lat = json["lat"] as? Double ?? 0.0
        self.lng = json["lng"] as? Double ?? 0.0
        self.driver_name = json["driver-name"] as? String ?? ""
        self.driver_car = json["driver-car"] as? String ?? ""
    }


    static func taxisList(json: [String : AnyObject]?) -> [Taxi]{
        guard let json = json else { return [] }
        
        let arrayTaxis = json["taxis"] as? [[String: AnyObject]]
        
        var taxis: [Taxi] = []
        arrayTaxis?.forEach({ (taxi) in
            taxis.append(Taxi(json: taxi))
        })

        return taxis
    }
    
}

