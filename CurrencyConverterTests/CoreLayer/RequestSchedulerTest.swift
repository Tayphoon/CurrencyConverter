//
//  RequestSchedulerTest.swift
//  StolichkiTests
//
//  Created by Tayphoon on 14/01/2018.
//  Copyright © 2018 Inostudio. All rights reserved.
//

import XCTest
import Alamofire
import OHHTTPStubs
@testable import CurrencyConverter

enum Products {
    static let baseURL = "https://test.com/api"
    
    case product(id: Int)
    case newProduct(product: Product)
    
    func builder() -> RequestBuilder {
        var builder: RequestBuilder
        
        switch self {
        case .product(let id):
            let params = ["id" : id]
            builder = RestRequestBuilder(path: "product", method:.get, params: params)
        case .newProduct(let product):
            builder = ObjectRequestBuilder(path: "product", object: product)
        }
        
        builder.baseURLString = Products.baseURL
        return builder
    }
}

class RequestSchedulerTest: BaseTestCase {
    
    func testRequestSchedulerObjectMapping() {
        // Given
        let stubbedJSON: [String: Any] = [
            "productId": 12,
            "productName": "some text",
            "imageURL": "http://images.com/skdm732.img",
            ]
        
        let url = NSURL(string: Products.baseURL)
        let host = url?.host
        stub(condition: isHost(host!) && isPath("/api/product")) { _ in
            return OHHTTPStubsResponse(jsonObject: stubbedJSON,
                                       statusCode: 200,
                                       headers: .none)
        }
        
        // When
        let builder = Products.product(id: 12).builder()
        let expectation = self.expectation(description: "calls the callback with a product object")
                
        // Then
        ApplicationAssembly.requestScheduler.execute(builder: builder) { (result: Result<Product>) in
            XCTAssertNil(result.error)
            XCTAssertNotNil(result.value)
            if let product = result.value {
                XCTAssertEqual(product.productId, stubbedJSON["productId"] as! Int)
                XCTAssertEqual(product.productName, stubbedJSON["productName"] as! String)
                XCTAssertEqual(product.imageURL, stubbedJSON["imageURL"] as! String)
            }
            
            expectation.fulfill()
        }
        
        self.waitForExpectations(timeout: timeout, handler: .none)
        
        // Tear Down
        //
        OHHTTPStubs.removeAllStubs()
    }
    
    func testRequestSchedulerPostObjectMapping() {
        // Given

        let product = Product(productId: 12,
                              productName: "some text",
                              imageURL: "http://images.com/skdm732.img")
        
        stub(condition: isPath("/api/product")) { request in
            XCTAssertNotNil(request.httpBodyStream, "HTTPBodyStream should not be nil")
            
            let stubbedJSON: [String: Any] = [
                "productId": product.productId,
                "productName": product.productName,
                "imageURL": product.imageURL,
                ]

            if let httpBodyStream = request.httpBodyStream {
                do {
                    let httpBody = Data(reading: httpBodyStream)
                    let json = try JSONSerialization.jsonObject(with: httpBody, options: .allowFragments)
                    
                    if let json = json as? NSObject {
                        XCTAssertEqual(json, stubbedJSON as NSObject)
                    } else {
                        XCTFail("json should be an NSObject")
                    }
                } catch {
                    XCTFail("json should not be nil")
                }
            }
            
            return OHHTTPStubsResponse(jsonObject: stubbedJSON,
                                       statusCode: 200,
                                       headers: .none)
        }
        
        // When
        let builder = Products.newProduct(product: product).builder()
        let expectation = self.expectation(description: "calls the callback with a product object")

        // Then
        ApplicationAssembly.requestScheduler.execute(builder: builder) { (result: Result<Product>) in
            XCTAssertNil(result.error)
            XCTAssertNotNil(result.value)
            if let resultProduct = result.value {
                XCTAssertEqual(resultProduct.productId, product.productId)
                XCTAssertEqual(resultProduct.productName, product.productName)
                XCTAssertEqual(resultProduct.imageURL, product.imageURL)
            }

            expectation.fulfill()
        }
        
        self.waitForExpectations(timeout: timeout, handler: .none)
        
        // Tear Down
        //
        OHHTTPStubs.removeAllStubs()
    }
}
