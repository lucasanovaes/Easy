//
//  Address.swift
//  Easy
//
//  Created by Lucas Antonelli Novaes on 25/02/2018.
//  Copyright © 2018 Lucas Novaes. All rights reserved.
//

import Foundation
import GoogleMaps

final class Address{
    
    var street: String
    var city: String
    var neighborhood: String
    
    init(address: GMSAddress){
        self.street = address.thoroughfare ?? "Unamed Road"
        self.city = address.locality ?? ""
        self.neighborhood = address.subLocality ?? ""
    }
}

