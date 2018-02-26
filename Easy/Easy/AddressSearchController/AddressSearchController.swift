//
//  AddressSearchController.swift
//  Easy
//
//  Created by iCasei Site on 26/02/2018.
//  Copyright © 2018 Lucas Novaes. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces

protocol AddressSearchControllerDelegate: class{
    func addressSearchController(_ controller: AddressSearchController, didSelect prediction: GMSAutocompletePrediction)
}

final class AddressSearchController: UIViewController {

    struct TableViewIdentifier{
        static var predictionsCellIdentifier = "AdressesPredictionCell"
        static var predictionsCell = "AdressesPredictionTableViewCell"
    }
    
    let tableView: UITableView
    let viewModel: AddressSearchViewModel
    let type: SearchType
    
    var searchController: UISearchController
    
    weak var delegate: AddressSearchControllerDelegate?

    enum SearchType: String{
        case source = "Source"
        case destination = "Destination"
    }
    
    init(type: SearchType){
        tableView = UITableView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        viewModel = AddressSearchViewModel()
        searchController = UISearchController(searchResultsController: nil)

        self.type = type

        super.init(nibName: nil, bundle: nil)        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = viewModel.viewConfiguration()
        self.view.addSubview(tableView)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchController.searchBar.placeholder = type.rawValue
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchResultsUpdater = self
        if #available(iOS 11.0, *) {
            navigationItem.searchController = searchController
        }
        definesPresentationContext = true
        
        tableView.showsVerticalScrollIndicator = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: TableViewIdentifier.predictionsCell, bundle: nil), forCellReuseIdentifier: TableViewIdentifier.predictionsCellIdentifier)
        tableView.dynamicSize()
    }
  
    // Make UISearchController active without have to scroll down
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if #available(iOS 11.0, *) {
            navigationItem.hidesSearchBarWhenScrolling = false
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if #available(iOS 11.0, *) {
            navigationItem.hidesSearchBarWhenScrolling = true
        }
    }
    
}

extension AddressSearchController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfPredictions(at: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewIdentifier.predictionsCellIdentifier) as! AdressesPredictionTableViewCell
        cell.fill(with: viewModel.predictionText(at: indexPath))
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        delegate?.addressSearchController(self, didSelect: viewModel.prediction(at: indexPath))
    }
    
}

extension AddressSearchController: UISearchResultsUpdating{
    
    func updateSearchResults(for searchController: UISearchController) {
        viewModel.findAddres(with: searchController.searchBar.text) { (placesPrediction, error) in
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
}
