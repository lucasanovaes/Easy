//
//  TaxiServices.swift
//  Easy
//
//  Created by Lucas Antonelli Novaes on 26/02/2018.
//  Copyright © 2018 Lucas Novaes. All rights reserved.
//

import Foundation
import CoreLocation

final class TaxiServices{
    
    private let endpoint = "http://quasinada-ryu.easytaxi.net.br/api/gettaxis/"
    var easyApi = EasyAPI()
    
    func fetchTaxis(at coordinate: CLLocationCoordinate2D, onComplete: @escaping ([Taxi], Error?) -> Void){
        easyApi.fetchData(in: endpoint, parameters: ["lat": "\(coordinate.latitude)", "lng": "\(coordinate.longitude)"]) { (json, error) in
           
            if error != nil{
                onComplete([], error)
                return
            }
            
            onComplete(Taxi.taxisList(json: json), nil)
        }
    }
    
}
