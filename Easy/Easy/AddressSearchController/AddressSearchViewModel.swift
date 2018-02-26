//
//  DestinationSearchViewModel.swift
//  Easy
//
//  Created by iCasei Site on 26/02/2018.
//  Copyright © 2018 Lucas Novaes. All rights reserved.
//

import Foundation
import UIKit
import GooglePlaces

final class AddressSearchViewModel{
    
    private let gmsPlacesClient = GMSPlacesClient()
    var predictions: [GMSAutocompletePrediction] = []
    
    func viewConfiguration() -> UIView{
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.isOpaque = true
        
        return view
    }
    
    func numberOfPredictions(at section: Int) -> Int{
        return predictions.count
    }
    
    func predictionText(at indexPath: IndexPath) -> NSAttributedString{
        return predictions[indexPath.row].attributedFullText
    }
    
    func prediction(at indexPath: IndexPath) -> GMSAutocompletePrediction{
        return predictions[indexPath.row]
    }
    
    func findAddres(with text: String?, onComplete: @escaping ([GMSAutocompletePrediction], Error?) -> Void){
        guard let text = text else {
            
            // set status null of search! User did no typed anything
            
            return
        }
        
        let filter = GMSAutocompleteFilter()
        filter.type = .address
        
        gmsPlacesClient.autocompleteQuery(text, bounds: nil, filter: filter) { [weak self] (predictions, error) in
            if let error = error{
                print("Error in autocomplete: \(error)")
                onComplete([], error)
                return
            }
        
            if let predictions = predictions {
                self?.predictions = predictions
                onComplete(predictions, nil)
            }
        }
    }
    
}

