//
//  MapControllerViewModel.swift
//  Easy
//
//  Created by iCasei Site on 23/02/2018.
//  Copyright © 2018 Lucas Novaes. All rights reserved.
//

import Foundation
import GoogleMaps

final class MapControllerViewModel {
    
    let userLocationManager = UserLocationManager()
    
    func fetchTaxis(onComplete: @escaping ([TaxiMarker]) -> Void){
        
    }
    
    func reverseGeocoding(onComplete: @escaping (Address) -> Void){
        guard let userLocation = userLocationManager.userLocation else { return }
        
        let geocoder = GMSGeocoder()
        geocoder.reverseGeocodeCoordinate(userLocation) { (response, error) in
            if error != nil { return }
            
            if let address = response?.firstResult(){
                onComplete(Address(address: address))
            }
        }
    }
    
}

