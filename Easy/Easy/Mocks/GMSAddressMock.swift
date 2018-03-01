//
//  GMSAddressMock.swift
//  EasyTests
//
//  Created by iCasei Site on 28/02/2018.
//  Copyright © 2018 Lucas Novaes. All rights reserved.
//

import Foundation
import GoogleMaps

final class GMSAddressMock: GMSAddress{
    
    var _thoroughfare: String = ""
    var _locality: String = ""
    var _subLocality: String = ""
    var _coordinate: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0)
    
    override var thoroughfare: String?{
        get{
            return _thoroughfare
        }
        set (newValue){
            _thoroughfare = newValue!
        }
    }
    
    override var locality: String?{
        get{
            return _locality
        }
        set (newValue){
            _locality = newValue!
        }
    }
    
    override var subLocality: String?{
        get{
            return _subLocality
        }
        set (newValue){
            _subLocality = newValue!
        }
    }
    
    override var coordinate: CLLocationCoordinate2D{
        get{
            return _coordinate
        }
        set (newValue){
            _coordinate = newValue
        }
    }
    
}



