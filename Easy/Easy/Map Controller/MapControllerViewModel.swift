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
    
    func fetchTaxisMarker(onComplete: @escaping ([TaxiMarker], Error?) -> Void){
        guard let sourceLocation = userLocationManager.sourceLocation else { return }
        TaxiServices().fetchTaxis(at: sourceLocation) { (taxis, error) in
            
            DispatchQueue.main.async {
                let taxisMarker = taxis.map({ TaxiMarker(taxi: $0) })
                onComplete(taxisMarker, error)
            }
            
        }
    }
    
    func reverseGeocodingFromSource(onComplete: @escaping (Address) -> Void){
        guard let sourceLocation = userLocationManager.sourceLocation else { return }
        reverseGeocodingFrom(location: sourceLocation) { (address) in
            onComplete(address)
        }
    }
    
    func reverseGeocodingFromDestination(onComplete: @escaping (Address) -> Void){
        guard let destinationLocation = userLocationManager.destinationLocation else { return }
        reverseGeocodingFrom(location: destinationLocation) { (address) in
            onComplete(address)
        }
    }
    
    private func reverseGeocodingFrom(location: CLLocationCoordinate2D, onComplete: @escaping (Address) -> Void){
        let geocoder = GMSGeocoder()
        geocoder.reverseGeocodeCoordinate(location) { (response, error) in
            if error != nil { return }
            
            if let address = response?.firstResult(){
                onComplete(Address(address: address))
            }
        }
    }
    
    func nearestTaxiInMeters(taxis: [TaxiMarker]) -> String{
        guard let sourceLocation = userLocationManager.sourceLocation else {
            return ""
        }
        
        let locationForCalculate = CLLocation(latitude: sourceLocation.latitude, longitude: sourceLocation.longitude)
        
        let nearest = taxis.min(by: { $0.location.distance(from: locationForCalculate) < $1.location.distance(from: locationForCalculate) })
        
        if let nearestLocation = nearest?.location{
            return "\(round(locationForCalculate.distance(from: nearestLocation) * 100) / 100) mts"
        }
        
        return ""
    }
    
}

