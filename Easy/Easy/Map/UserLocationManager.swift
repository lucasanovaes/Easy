//
//  UserLocationManager.swift
//  Easy
//
//  Created by Lucas Antonelli Novaes on 22/02/2018.
//  Copyright © 2018 Lucas Novaes. All rights reserved.
//

import Foundation
import CoreLocation

protocol UserLocationManagerDelegate: class{
    func userLocationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
}

final class UserLocationManager: NSObject{
    
    private let locationManager = CLLocationManager()
    weak var delegate: UserLocationManagerDelegate?
    
    init(delegate: UserLocationManagerDelegate? = nil){
        super.init()
        self.delegate = delegate
    }
    
    func startUpdateLocations(onComplete: @escaping (_ hasAuthorizarion: Bool) -> Void){
        self.locationManager.requestWhenInUseAuthorization()
        
        let locationServicesEneabled = CLLocationManager.locationServicesEnabled()
        
        if locationServicesEneabled{
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
        
        onComplete(locationServicesEneabled)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        delegate?.userLocationManager(manager, didUpdateLocations: locations)
    }
    
}


extension UserLocationManager: CLLocationManagerDelegate { }
