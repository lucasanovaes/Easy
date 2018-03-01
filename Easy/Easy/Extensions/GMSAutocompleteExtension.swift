//
//  GMSAutocompleteExtension.swift
//  Easy
//
//  Created by Lucas Antonelli Novaes on 28/02/2018.
//  Copyright © 2018 Lucas Novaes. All rights reserved.
//

import Foundation
import GooglePlaces

extension GMSAutocompletePrediction{
    
    class func transform(_ into: [GMSAutocompletePrediction]) -> [AutocompletePrediction]{
        return into.map({ AutocompletePrediction(attributedFullText: $0.attributedFullText, placeID: $0.placeID) })
    }
    
}
