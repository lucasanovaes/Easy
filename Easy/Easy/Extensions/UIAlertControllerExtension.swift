//
//  File.swift
//  Easy
//
//  Created by Lucas Antonelli Novaes on 25/02/2018.
//  Copyright © 2018 Lucas Novaes. All rights reserved.
//

import UIKit

extension UIAlertController{
    
    class func showAlertWith(title: String, and message: String, in controller: UIViewController){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (confirm) in }))
        controller.present(alert, animated: true, completion: nil)
    }
    
}
