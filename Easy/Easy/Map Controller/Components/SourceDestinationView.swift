//
//  SourceDestinationView.swift
//  Easy
//
//  Created by iCasei Site on 23/02/2018.
//  Copyright © 2018 Lucas Novaes. All rights reserved.
//

import UIKit

protocol SourceDestinationViewDelegate: class{
    func sourceDestinationView(_ view: SourceDestinationView, didSelectWith type: AddressSearchController.SearchType)
}

@IBDesignable
final class SourceDestinationView: UIView {

    @IBOutlet private weak var sourceStreetName: UILabel!
    @IBOutlet private weak var sourceComplement: UILabel!
    @IBOutlet private weak var sourcePlaceholderView: UIView!
    
    @IBOutlet private weak var destinationStreetName: UILabel!
    @IBOutlet private weak var destinationComplement: UILabel!
    @IBOutlet private weak var destinationPlaceholderView: UIView!
    
    private var contentView : UIView!
    
    weak var delegate: SourceDestinationViewDelegate?
        
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
    
    func setSource(address: Address){
        sourceStreetName.text = address.street
        sourceComplement.text = "\(address.city) | \(address.neighborhood)"
        
        sourcePlaceholderView.isHidden = true
    }
    
    func setDestination(address: Address){
        destinationStreetName.text = address.street
        destinationComplement.text = "\(address.city) | \(address.neighborhood)"
        
        destinationPlaceholderView.isHidden = true
    }
    
    func showSourceLoader(){
        sourcePlaceholderView.isHidden = false
    }
    
    func showDestinationLoader(){
        destinationPlaceholderView.isHidden = false
    }
    
    @IBAction private func SearchForDestination(_ sender: UIButton) {
        delegate?.sourceDestinationView(self, didSelectWith: .destination)
    }
    
    @IBAction func SearchForSource(_ sender: UIButton) {
        delegate?.sourceDestinationView(self, didSelectWith: .source)
    }
    
}

//MARK: Setup methods
extension SourceDestinationView{
    
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

