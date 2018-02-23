//
//  AppDelegate.swift
//  Easy
//
//  Created by iCasei Site on 22/02/2018.
//  Copyright © 2018 Lucas Novaes. All rights reserved.
//

import UIKit
import GoogleMaps

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var coordinator: Coordinator!
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        coordinator = Coordinator(appLaunchOptions: launchOptions)
        coordinator.showInitialController()
        
        GMSServices.provideAPIKey("AIzaSyD3ebvGrOuTWVqVVq_SnCgCGOXkN_iJOAk")
        
        return true
    }
    
}
