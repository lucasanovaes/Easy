//
//  MapController.swift
//  Easy
//
//  Created by Lucas Antonelli Novaes on 22/02/2018.
//  Copyright © 2018 Lucas Novaes. All rights reserved.
//

import UIKit
import GoogleMaps

class MapController: UIViewController {

    @IBOutlet weak var mapView: GMSMapView!
        
    let viewModel = MapControllerViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        
        viewModel.userLocationManager.delegate = self
        viewModel.userLocationManager.startUpdateLocations { (hasAuthorization) in
            // show error handler
        }
    }

}

extension MapController: UserLocationManagerDelegate, GMSMapViewDelegate{
    
    func userLocationManager(_ manager: CLLocationManager, didUpdateLocation location: CLLocation, camera: GMSCameraPosition) {
        mapView.camera = camera
        
        viewModel.reverseGeocoding(for: location.coordinate) { (address) in
            // set address in address component
        }
    }
    
    func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
        viewModel.fetchTaxis { [weak self] (taxis) in
            self?.mapView.clear()
        }
    }
    
}

