//
//  MapController.swift
//  Easy
//
//  Created by Lucas Antonelli Novaes on 22/02/2018.
//  Copyright © 2018 Lucas Novaes. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces

protocol MapControllerDelegate: class{
    func showAddressSearchController(from: MapController, with type: AddressSearchController.SearchType)
}

final class MapController: UIViewController {

    @IBOutlet private weak var searchComponentTopSpace: NSLayoutConstraint!
    @IBOutlet private weak var mapView: GMSMapView!
    @IBOutlet private weak var sourceDestinationView: SourceDestinationView!
    @IBOutlet weak var nearestTaxiView: NearestTaxiView!
    
    let viewModel = MapControllerViewModel()
    
    weak var delegate: MapControllerDelegate?
    
    init(delegate: MapControllerDelegate? = nil){
        self.delegate = delegate
        super.init(nibName: "MapController", bundle: nil)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Easy app"
        
        if #available(iOS 11.0, *) {
            searchComponentTopSpace.constant = 12
        }
        
        mapView.delegate = self
        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true
        
        sourceDestinationView.delegate = self
        
        viewModel.userLocationManager.delegate = self
        viewModel.userLocationManager.startUpdateLocations { (hasAuthorization) in
            if !hasAuthorization{
                UIAlertController.showAlertWith(title: "Atention", and: "You should enable services location for Easy app. Go to 'Settings' > 'Services location' and provide access", in: self)
            }
        }
    }
    
    private func fetchTaxis(){
        viewModel.fetchTaxisMarker { [weak self] (taxis, error) in
            if error != nil{
                // Handle error. Show some pop-up etc..
                return
            }
            
            taxis.forEach({ (taxiMarker) in
                DispatchQueue.main.async {
                    taxiMarker.map = self?.mapView
                }
            })
            
            self?.nearestTaxiView.setDistante(taxis: taxis, sourceLocation: self?.viewModel.userLocationManager.sourceLocation)
        }
    }
    
    // Set new address source. Responsable for call reverseGeocoding and get all near taxis.
    private func setSource(){
        mapView.clear()
        
        fetchTaxis()
        
        sourceDestinationView.showSourceLoader()
        viewModel.reverseGeocodingFromSource(){ [weak self] (address) in
            self?.sourceDestinationView.setSource(address: address)
        }
    }
    
    // Set new address destination
    private func setDestination(){
        sourceDestinationView.showDestinationLoader()
        viewModel.reverseGeocodingFromDestination(){ [weak self] (address) in
            self?.sourceDestinationView.setDestination(address: address)
        }
    }

}

// MARK: Methods releated to GMSMapView location
extension MapController: UserLocationManagerDelegate, GMSMapViewDelegate{
    
    // Called just one time, when got user location. Move camera to current position and set the source address.
    func userLocationManager(_ manager: CLLocationManager, didUpdateLocation location: CLLocation, camera: GMSCameraPosition) {
        mapView.camera = camera
        setSource()
    }
    
    // Called every time the user drags the map. Set new source location in viewModel 'sourceLocation'.
    func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
        viewModel.userLocationManager.sourceLocation = position.target
        setSource()
    }
    
    // Prevent camera from moving when tapping marker
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        mapView.selectedMarker = marker
        return true
    }
}

// MARK: User selected some destination address
extension MapController: AddressSearchControllerDelegate{
    
    // Recieve new GMSPlace and update sourceDestion in userLocationManage 'destinationLocation'.
    func addressSearchController(_ controller: AddressSearchController, didSelect place: GMSPlace) {
        viewModel.userLocationManager.destinationLocation = place.coordinate
        setDestination()
    }
    
}

// MARK: Router Navigation
extension MapController: SourceDestinationViewDelegate{
    
    func sourceDestinationView(_ view: SourceDestinationView, didSelectWith type: AddressSearchController.SearchType) {
        delegate?.showAddressSearchController(from: self, with: type)
    }

}

