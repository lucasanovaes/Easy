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
    func addressSearchController(_ controller: AddressSearchController, didSelect place: GMSPlace)
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
    
    init(type: SearchType, delegate: AddressSearchControllerDelegate? = nil){
        tableView = UITableView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        viewModel = AddressSearchViewModel()
        searchController = UISearchController(searchResultsController: nil)

        self.type = type
        self.delegate = delegate

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
        }else{
            tableView.tableHeaderView = searchController.searchBar
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
        
        let backButton: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(done))
        self.navigationItem.rightBarButtonItem = backButton
        
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
    
    @objc private func done() {
        self.dismiss(animated: true, completion: nil)
    }
    
}

extension AddressSearchController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfPredictions(at: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch viewModel.searchState{

        // Want to customize the states? Simply change default UITableViewCell(:) for the custom class you want...
        case .status_null:
            let cell = UITableViewCell(style: .default, reuseIdentifier: "status_null")
            cell.textLabel?.text = "Type and search for a new place"
            return cell
            
        case .success:
            let cell = tableView.dequeueReusableCell(withIdentifier: TableViewIdentifier.predictionsCellIdentifier) as! AdressesPredictionTableViewCell
            cell.fill(with: viewModel.predictionText(at: indexPath))
            return cell
            
        case .empty:
            let cell = UITableViewCell(style: .default, reuseIdentifier: "empty")
            cell.textLabel?.text = "Wow! No results"
            return cell
            
        case .error:
            let cell = UITableViewCell(style: .default, reuseIdentifier: "error")
            cell.textLabel?.text = "Ops...API Error"
            return cell
        }

    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        UILoader.shared.showLoader(in: view)
        viewModel.findAddress(viewModel.prediction(at: indexPath).placeID) {(place, error) in
            UILoader.shared.hideLoader()
            
            self.delegate?.addressSearchController(self, didSelect: place!)
            self.navigationController?.dismiss(animated: true, completion: nil)
        }
    }
    
}

extension AddressSearchController: UISearchResultsUpdating{
    
    func updateSearchResults(for searchController: UISearchController) {
        viewModel.findAddres(with: searchController.searchBar.text) { (placesPrediction) in
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
}
