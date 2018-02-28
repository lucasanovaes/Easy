//
//  EasyTests.swift
//  EasyTests
//
//  Created by iCasei Site on 22/02/2018.
//  Copyright © 2018 Lucas Novaes. All rights reserved.
//

import XCTest
import GoogleMaps
@testable import Easy

class EasyTests: XCTestCase {
    
    private lazy var taxisData = EasyTests.data(for: "Taxis")
    var mapControllerViewModel: MapControllerViewModel!
    
    override func setUp() {
        super.setUp()
        mapControllerViewModel = MapControllerViewModel()
    }
    
    override func tearDown() {
        super.tearDown()
        mapControllerViewModel = nil
    }
    
    // MARK: Support methods
    private class func url(for resource: String) -> URL {
        return Bundle(for: EasyTests.self).url(forResource: resource, withExtension: "json")!
    }
    
    private class func data(for resource: String) -> Data {
        let url = self.url(for: resource)
        return try! Data(contentsOf: url)
    }
    
    func test_parsing_taxis_count_from_json(){
        let json = try? JSONSerialization.jsonObject(with: taxisData, options:.allowFragments) as! [String : AnyObject]
        let taxis = Taxi.taxisList(json: json)
        
        XCTAssert(taxis.count == 99, "Wrong number of taxis in array after data parse")
    }
    
    func test_parsing_taxis_values_from_json(){
        let json = try? JSONSerialization.jsonObject(with: taxisData, options:.allowFragments) as! [String : AnyObject]
        let taxis = Taxi.taxisList(json: json)
        
        XCTAssert(taxis[0].lat == -23.309563936369585, "Wrong 'lat' parsing taxis")
        XCTAssert(taxis[0].lng == -85.30979401644655, "Wrong 'lng' parsing taxis")
        XCTAssert(taxis[0].driver_name == "Driver Test", "Wrong 'driver-name' parsing taxis")
        XCTAssert(taxis[0].driver_car == "Driver Car", "Wrong 'driver-car' parsing taxis")
    }
    
    func test_filling_Address_properly_from_GMSAddress(){
        let gmsMockAddress = GMSAddressMock()
        gmsMockAddress.thoroughfare = "Rua Luis Alonso Perez"
        gmsMockAddress.locality = "SBC"
        gmsMockAddress.subLocality = "Jordanopolis"
        gmsMockAddress.coordinate = CLLocationCoordinate2D(latitude: -21.00911, longitude: -46.123321)
        
        let address = Address(address: gmsMockAddress)
        XCTAssert(address.street == "Rua Luis Alonso Perez", "'Address' setting wrong value for 'street'")
        XCTAssert(address.city == "SBC", "'Address' setting wrong value for 'city'")
        XCTAssert(address.neighborhood == "Jordanopolis", "'Address' setting wrong value for 'neighborhood'")
        XCTAssert(address.coordinate?.latitude == -21.00911, "'Address' setting wrong value for 'coordinate - latitude'")
        XCTAssert(address.coordinate?.longitude == -46.123321, "'Address' setting wrong value for 'coordinate - longitude'")
    }
    
    func test_calculating_nearest_taxi_from_given_location(){
        
        let viewModel = MapControllerViewModel()
        viewModel.userLocationManager.sourceLocation = CLLocationCoordinate2D(latitude: -23.3013639363362185, longitude: -85.30433945164535) // mudar para uma localização real
        
        let json = try? JSONSerialization.jsonObject(with: taxisData, options:.allowFragments) as! [String : AnyObject]
        let taxis = Taxi.taxisList(json: json)
        
        let taxisMarker = taxis.map({ TaxiMarker(taxi: $0) })
        
        let nearest = viewModel.nearestTaxiInMeters(taxis: taxisMarker)
        XCTAssert(nearest == "998.27 mts", "Wrong distance when calculating nearest taxi")
    }
    
    
    
}

