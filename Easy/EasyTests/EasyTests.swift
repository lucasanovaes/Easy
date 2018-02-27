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
    
    // MARK: Tests releated to MapController
    func test_parsing_taxis_count(){
        let json = try? JSONSerialization.jsonObject(with: taxisData, options:.allowFragments) as! [String : AnyObject]
        let taxis = Taxi.taxisList(json: json)
        
        XCTAssert(taxis.count == 99, "Wrong number of taxis in array after data parse")
    }
    
    func test_parsing_taxis_values(){
        let json = try? JSONSerialization.jsonObject(with: taxisData, options:.allowFragments) as! [String : AnyObject]
        let taxis = Taxi.taxisList(json: json)
        
        XCTAssert(taxis[0].lat == -23.309563936369585, "Wrong 'lat' parsing taxis")
        XCTAssert(taxis[0].lng == -85.30979401644655, "Wrong 'lng' parsing taxis")
        XCTAssert(taxis[0].driver_name == "Driver Test", "Wrong 'driver-name' parsing taxis")
        XCTAssert(taxis[0].driver_car == "Driver Car", "Wrong 'driver-car' parsing taxis")
    }
    
    

}

