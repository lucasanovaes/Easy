//
//  UITableViewExtension.swift
//  Easy
//
//  Created by iCasei Site on 26/02/2018.
//  Copyright © 2018 Lucas Novaes. All rights reserved.
//

import Foundation
import UIKit

extension UITableView{
    
    func dynamicSize(){
        self.estimatedRowHeight = 40
        self.rowHeight = UITableViewAutomaticDimension
        self.setNeedsLayout()
        self.layoutIfNeeded()
    }
    
}

