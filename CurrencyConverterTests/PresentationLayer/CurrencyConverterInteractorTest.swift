//
//  CurrencyConverterInteractorTest.swift
//  CurrencyConverterTests
//
//  Created by Tayphoon on 30/09/2018.
//  Copyright © 2018 Tayphoon. All rights reserved.
//

import XCTest
import OHHTTPStubs
@testable import CurrencyConverter

class CurrencyConverterInteractorTest: BaseTestCase {
    
    static var baseURL = "revolut.duckdns.org"
    
    var currencyServices: CurrencyServices!
    var interactor: CurrencyConverterInteractorInput!

    override func setUp() {
        super.setUp()
        
        currencyServices = CurrencyServicesImpl(ApplicationAssembly.requestScheduler, baseURL: "https://\(CurrencyServicesTests.baseURL)")
        let currencyInteractor = CurrencyConverterInteractor()
        currencyInteractor.currencyServices = currencyServices
        interactor = currencyInteractor
        
        
        stub(condition: isHost(CurrencyServicesTests.baseURL) && isPath("/latest")) { _ in
            // Stub it with our "wsresponse.json" stub file (which is in same bundle as self)
            let stubPath = OHPathForFile("currencies.json", type(of: self))
            return fixture(filePath: stubPath!, headers: ["Content-Type":"application/json"])
        }
    }
    
    override func tearDown() {
        super.tearDown()
        
        OHHTTPStubs.removeAllStubs()
    }
    
    func testObtainRates() {
        // Given
        let currency = Currency(name: "EUR", flag: "", value: 100)
        
        // When
        let expectation = self.expectation(description: "calls the callback with array with rates")
        interactor.currencies(for: currency, completion: { (currencies: [Currency]?, error: Error?) in
            XCTAssertNil(error)
            XCTAssertNotNil(currencies)
            XCTAssertEqual(currencies?.count, 32)
            
            expectation.fulfill()
        })
        
        self.waitForExpectations(timeout: timeout, handler: .none)
    }
}
