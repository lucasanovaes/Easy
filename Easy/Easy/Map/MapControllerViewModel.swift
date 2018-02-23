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
    
    func reverseGeocoding(for coordinate: CLLocationCoordinate2D, onComplete: @escaping (String) -> Void){
        let geocoder = GMSGeocoder()
        
        geocoder.reverseGeocodeCoordinate(coordinate) { (response, error) in
            if error != nil { return }
            
            if let address = response?.firstResult(){
                if let lines = address.lines{
                    let readableAddress = lines.joined(separator: "\n")
                    print("Current address: \(readableAddress)")
                    onComplete(readableAddress)
                }                
            }
        }
    }
    
}

