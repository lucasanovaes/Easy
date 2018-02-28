//
//  NearestTaxiView.swift
//  Easy
//
//  Created by iCasei Site on 27/02/2018.
//  Copyright © 2018 Lucas Novaes. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation

final class NearestTaxiView: UIView{
    
    @IBOutlet weak var distanceLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        xibSetup()
    }
    
    private var contentView : UIView!

    func setDistante(taxis: [TaxiMarker], sourceLocation: CLLocationCoordinate2D?){
        
        guard let sourceLocation = sourceLocation else {
            distanceLabel.text = ""
            return
        }
        let locationForCalculate = CLLocation(latitude: sourceLocation.latitude, longitude: sourceLocation.longitude)
        
        let nearest = taxis.min(by: { $0.location.distance(from: locationForCalculate) < $1.location.distance(from: locationForCalculate) })
        
        if let nearestLocation = nearest?.location{
            distanceLabel.text = "\(round(locationForCalculate.distance(from: nearestLocation) * 100) / 100) mts"
        }
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

