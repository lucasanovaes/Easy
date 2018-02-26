//
//  MapController.swift
//  Easy
//
//  Created by Lucas Antonelli Novaes on 22/02/2018.
//  Copyright © 2018 Lucas Novaes. All rights reserved.
//

import UIKit
import GoogleMaps

protocol MapControllerDelegate: class{
    func showDestinationSearchController(from: MapController)
}

class MapController: UIViewController {

    @IBOutlet private weak var mapView: GMSMapView!
    @IBOutlet private weak var sourceDestinationView: SourceDestinationView!
    
    weak var delegate: MapControllerDelegate?
    let viewModel = MapControllerViewModel()
    
    init(delegate: MapControllerDelegate? = nil){
        self.delegate = delegate
        super.init(nibName: "MapController", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
        
        sourceDestinationView.showSourceLoader()
        viewModel.reverseGeocoding(){ [weak self] (address) in            
            self?.sourceDestinationView.setSource(address: address)
        }
        
    }
    
}

