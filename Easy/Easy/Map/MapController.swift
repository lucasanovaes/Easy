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
    
    let userLocationManager = UserLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userLocationManager.delegate = self
        userLocationManager.startUpdateLocations { (hasAuthorization) in
            // show error handler
        }
    }

}

extension MapController: UserLocationManagerDelegate{
    
    func userLocationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print(locations)
    }
}
