//
//  NearestTaxiView.swift
//  Easy
//
//  Created by iCasei Site on 27/02/2018.
//  Copyright © 2018 Lucas Novaes. All rights reserved.
//

import Foundation
import UIKit

final class NearestTaxiView: UIView{
    
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        xibSetup()
    }
    
    private var contentView : UIView!

    func setDistante(){
        
    }
    
    private func showDistanceLoader(){
        distanceLabel.isHidden = true
        activityIndicator.startAnimating()
        activityIndicator.isHidden = false
    }
    
    private func hideDistanceLoader(){
        distanceLabel.isHidden = false
        activityIndicator.stopAnimating()
        activityIndicator.isHidden = true
    }
    
}

// MARK: Setup methods
extension NearestTaxiView{
    
    private func xibSetup() {
        contentView = loadViewFromNib()
        contentView.frame = bounds
        contentView.autoresizingMask = [UIViewAutoresizing.flexibleWidth, UIViewAutoresizing.flexibleHeight]
        addSubview(contentView)
        
        setupLayer()
    }
    
    private func loadViewFromNib() -> UIView! {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil).first as! UIView
        
        return view
    }
    
    private func setupView(){
        setupLayer()
    }
    
    private func setupLayer(){
        self.layer.cornerRadius = 2
        self.layer.shadowRadius = 2.0
        self.layer.shadowOpacity = 0.36
        self.layer.shadowOffset = CGSize(width: 0, height: 2)
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.main.scale
    }
    
}

