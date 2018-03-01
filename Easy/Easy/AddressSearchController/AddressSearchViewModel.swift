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
    
    enum SearchState{
        case status_null
        case success
        case empty
        case error
    }
    
    var searchState: SearchState = .status_null
    
    private let gmsPlacesClient = GMSPlacesClient()
    
    var predictions: [AutocompletePrediction] = []
    
    func viewConfiguration() -> UIView{
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.isOpaque = true
        
        return view
    }
    
    func numberOfPredictions(at section: Int) -> Int{
        switch searchState{
        case .status_null, .empty, .error:
            return 1
        case .success:
            return predictions.count
        }
    }
    
    func predictionText(at indexPath: IndexPath) -> NSAttributedString{
        return predictions[indexPath.row].attributedFullText
    }
    
    func prediction(at indexPath: IndexPath) -> AutocompletePrediction{
        return predictions[indexPath.row]
    }
    
    func findAddres(with text: String?, onComplete: @escaping ([AutocompletePrediction]) -> Void){
        if text == nil || text == ""{
            searchState = .status_null
            onComplete([])
            return
        }
        
        let filter = GMSAutocompleteFilter()
        filter.type = .address
        
        gmsPlacesClient.autocompleteQuery(text!, bounds: nil, filter: filter) { [weak self] (predictions, error) in
            if let error = error{
                self?.searchState = .error
                print("Error in autocomplete: \(error)")
                onComplete([])
                return
            }
            
            if let predictions = predictions {
                self?.searchState = predictions.count > 0 ? .success : .empty
                let transformedPredictions = GMSAutocompletePrediction.transform(predictions)
                self?.predictions = transformedPredictions
                onComplete(transformedPredictions)
            }
        }
    }
    
    func findAddress(_ placeId: String?, onComplete: @escaping (GMSPlace?, Error?) -> Void){
        guard let placeId = placeId else { return }
        
        gmsPlacesClient.lookUpPlaceID(placeId) { (place, error) in
            if let error = error {
                onComplete(nil, error)
                return
            }
            
            guard let place = place else {
                print("Any place details for \(placeId) :")
                onComplete(nil, nil)
                return
            }
            
            onComplete(place, nil)
        }
    }
    
}

