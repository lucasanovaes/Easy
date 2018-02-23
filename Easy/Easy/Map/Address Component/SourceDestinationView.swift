//
//  SourceDestinationView.swift
//  Easy
//
//  Created by iCasei Site on 23/02/2018.
//  Copyright © 2018 Lucas Novaes. All rights reserved.
//

import UIKit

class SourceDestinationView: UIView {

    @IBOutlet weak var sourceAddress: UITextField!
    @IBOutlet weak var destinationAddress: UITextField!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    

}

