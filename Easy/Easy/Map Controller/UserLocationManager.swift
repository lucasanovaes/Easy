//
//  UserLocationManager.swift
//  Easy
//
//  Created by Lucas Antonelli Novaes on 22/02/2018.
//  Copyright © 2018 Lucas Novaes. All rights reserved.
//

import Foundation
import CoreLocation
import GoogleMaps

protocol UserLocationManagerDelegate: class{
    func userLocationManager(_ manager: CLLocationManager, didUpdateLocation location: CLLocation, camera: GMSCameraPosition)
}

final class UserLocationManager: NSObject{
    
    private let locationManager: CLLocationManager = CLLocationManager()
    private var gmsCameraPosition: GMSCameraPosition = GMSCameraPosition.camera(withTarget: CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0), zoom: 0.0)

    var sourceLocation: CLLocationCoordinate2D?
    
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
}

extension UserLocationManager: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
       
        sourceLocation = location.coordinate
        
        gmsCameraPosition = GMSCameraPosition.camera(withLatitude: location.coordinate.latitude, longitude: location.coordinate.longitude, zoom: 16.0)
        
        locationManager.stopUpdatingLocation()
        delegate?.userLocationManager(manager, didUpdateLocation: location, camera: gmsCameraPosition)
    }
    
}
