//
//  SourceDestinationView.swift
//  Easy
//
//  Created by iCasei Site on 23/02/2018.
//  Copyright © 2018 Lucas Novaes. All rights reserved.
//

import UIKit

@IBDesignable
final class SourceDestinationView: UIView {

    @IBOutlet private weak var sourceStreetName: UILabel!
    @IBOutlet private weak var sourceComplement: UILabel!
    
    @IBOutlet private weak var destinationStreetName: UILabel!
    @IBOutlet private weak var destinationComplement: UILabel!
    
    private var contentView : UIView!

    override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        xibSetup()
        setupView()
    }
    
    private func xibSetup() {
        contentView = loadViewFromNib()
        contentView.frame = bounds
        contentView.autoresizingMask = [UIViewAutoresizing.flexibleWidth, UIViewAutoresizing.flexibleHeight]
        addSubview(contentView)
    }
    
    private func loadViewFromNib() -> UIView! {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil).first as! UIView
        
        return view
    }
    
    func setSource(address: Address){
        sourceStreetName.text = address.street
        sourceComplement.text = "\(address.city) | \(address.neighborhood)"
    }
    
    func setDestination(address: Address){
        destinationStreetName.text = address.street
        destinationComplement.text = "\(address.city) | \(address.neighborhood)"
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

