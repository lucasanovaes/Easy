//
//  AdressesPredictionTableViewCell.swift
//  Easy
//
//  Created by iCasei Site on 26/02/2018.
//  Copyright © 2018 Lucas Novaes. All rights reserved.
//

import UIKit
import GooglePlaces

class AdressesPredictionTableViewCell: UITableViewCell {

    @IBOutlet private weak var address: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func fill(with address: NSAttributedString){
        self.address.attributedText = address
    }

}

