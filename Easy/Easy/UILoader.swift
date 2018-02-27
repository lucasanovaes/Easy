//
//  UILoader.swift
//  Easy
//
//  Created by Lucas Antonelli Novaes on 26/02/2018.
//  Copyright © 2018 Lucas Novaes. All rights reserved.
//

import Foundation
import UIKit

public class UILoader{
    
    var contentView : UIView!
    var activityIndicator : UIActivityIndicatorView!
    
    class var shared: UILoader {
        struct Static {
            static let instance: UILoader = UILoader()
        }
        return Static.instance
    }
    
    init(){
        self.contentView = UIView()
        self.activityIndicator = UIActivityIndicatorView()
        
        contentView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        contentView.backgroundColor = UIColor(white: 0, alpha: 0.7)
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = 10
        contentView.layer.zPosition = 1
        
        activityIndicator.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        activityIndicator.center = CGPoint(x: contentView.bounds.width / 2, y: contentView.bounds.height / 2)
        activityIndicator.activityIndicatorViewStyle = .whiteLarge
        
        contentView.addSubview(activityIndicator)
    }
    
    public func showLoader(in view: UIView) {
        contentView.center = view.center
        view.addSubview(contentView)
        activityIndicator.startAnimating()
    }
    
    public func hideLoader() {
        activityIndicator.stopAnimating()
        contentView.removeFromSuperview()
    }
}
