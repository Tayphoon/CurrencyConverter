//
//  CurrencyServicesTests.swift
//  CurrencyConverterTests
//
//  Created by Tayphoon on 30/09/2018.
//  Copyright © 2018 Tayphoon. All rights reserved.
//

import XCTest
import OHHTTPStubs
@testable import CurrencyConverter

class CurrencyServicesTests: BaseTestCase {
    
    static var baseURL = "revolut.duckdns.org"
    
    var service: CurrencyServices!
    
    override func setUp() {
        super.setUp()
        
        service = CurrencyServicesImpl(ApplicationAssembly.requestScheduler, baseURL: "https://\(CurrencyServicesTests.baseURL)")
    }
    
    func testObtainRates() {
        // Given
        let currency = "EUR"

        stub(condition: isHost(CurrencyServicesTests.baseURL) && isPath("/latest")) { _ in
            // Stub it with our "wsresponse.json" stub file (which is in same bundle as self)
            let stubPath = OHPathForFile("currencies.json", type(of: self))
            return fixture(filePath: stubPath!, headers: ["Content-Type":"application/json"])
        }
        
        // When
        let expectation = self.expectation(description: "calls the callback with array with rates")
        service.rates(for: currency, completion: { (rates: [CurrencyRate]?, error: Error?) in
            XCTAssertNil(error)
            XCTAssertNotNil(rates)
            XCTAssertEqual(rates?.count, 32)

            expectation.fulfill()
        })
        
        self.waitForExpectations(timeout: timeout, handler: .none)
        
        // Tear Down
        //
        OHHTTPStubs.removeAllStubs()
    }
}
