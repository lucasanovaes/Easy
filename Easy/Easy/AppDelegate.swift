//
//  AppDelegate.swift
//  Easy
//
//  Created by iCasei Site on 22/02/2018.
//  Copyright © 2018 Lucas Novaes. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var coordinator: Coordinator!
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        coordinator = Coordinator(appLaunchOptions: launchOptions)
        coordinator.showInitialController()
        
        GMSServices.provideAPIKey("AIzaSyBj7gKmjNNG2aOlys-z9nNhqIWBZjdLdCc")
        GMSPlacesClient.provideAPIKey("AIzaSyBj7gKmjNNG2aOlys-z9nNhqIWBZjdLdCc")
        
        return true
    }
    
}
