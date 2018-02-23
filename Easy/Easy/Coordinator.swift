//
//  Coordinator.swift
//  Easy
//
//  Created by Lucas Antonelli Novaes on 22/02/2018.
//  Copyright © 2018 Lucas Novaes. All rights reserved.
//

import Foundation
import UIKit

final class Coordinator{
    
    fileprivate var window: UIWindow
    private var appLaunchOptions: [UIApplicationLaunchOptionsKey: Any]?
    
    fileprivate var mapNavigationController: UINavigationController?

    init(appLaunchOptions: [UIApplicationLaunchOptionsKey: Any]?) {
        self.appLaunchOptions = appLaunchOptions
        self.window = UIWindow(frame: UIScreen.main.bounds)
        window.makeKeyAndVisible()
    }
    
    func showInitialController(){
        mapNavigationController = UINavigationController(rootViewController: UIViewController())
        window.rootViewController = mapNavigationController
    }
    
}
