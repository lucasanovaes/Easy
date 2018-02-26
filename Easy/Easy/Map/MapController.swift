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

    @IBOutlet private weak var mapView: GMSMapView!
    @IBOutlet private weak var sourceDestinationView: SourceDestinationView!
    
        
    let viewModel = MapControllerViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true
        
        viewModel.userLocationManager.delegate = self
        viewModel.userLocationManager.startUpdateLocations { (hasAuthorization) in
            if !hasAuthorization{
                UIAlertController.showAlertWith(title: "Atention", and: "You should enable services location for Easy app. Go to 'Settings' > 'Services location' and provide access", in: self)
            }
        }
    }

}

extension MapController: UserLocationManagerDelegate, GMSMapViewDelegate{
    
    func userLocationManager(_ manager: CLLocationManager, didUpdateLocation location: CLLocation, camera: GMSCameraPosition) {
        mapView.camera = camera
        setDestination()
    }
    
    // Verificar para incluir uma classe que extensa GMSMapViewDelegate e fazer tudo lá. Criar um delegate igual o UserLocationManager e centralizar tudo nessas classes
    func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
        viewModel.userLocationManager.userLocation = position.target
        setDestination()
    }
    
    private func setDestination(){
        mapView.clear()
        
        viewModel.fetchTaxis { (taxis) in
            // show taxis in mapView
        }
        
        viewModel.reverseGeocoding(){ [weak self] (address) in
            self?.sourceDestinationView.setSource(address: address)
        }
        
    }
    
}

