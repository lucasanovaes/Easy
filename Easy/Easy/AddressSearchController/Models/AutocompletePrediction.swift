//
//  AutocompletePrediction.swift
//  Easy
//
//  Created by Lucas Antonelli Novaes on 28/02/2018.
//  Copyright © 2018 Lucas Novaes. All rights reserved.
//

import Foundation

// This 'Bridge' is necessary to make the code more testable
struct AutocompletePrediction{
    
    var attributedFullText: NSAttributedString
    var placeID: String?
    
    init(attributedFullText: NSAttributedString, placeID: String?) {
        self.attributedFullText = attributedFullText
        self.placeID = placeID
    }
    
}

