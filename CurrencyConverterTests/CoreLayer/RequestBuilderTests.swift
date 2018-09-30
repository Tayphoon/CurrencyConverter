//
//  RequestBuilderTests.swift
//  CurrencyConverterTests
//
//  Created by Tayphoon on 08/09/2018.
//  Copyright © 2018 Tayphoon. All rights reserved.
//

import XCTest
@testable import CurrencyConverter

class RequestBuilderTests: BaseTestCase {
    
    func testRequestBuilderInitWithPathParams() {
        // Given
        let path = "login"
        let params = ["userId" : "12"]
        let baseURL = "hhtps://test.com"
        
        // When
        var builder = RestRequestBuilder(path: path, params: params)
        builder.baseURLString = baseURL
        
        // Then
        XCTAssertNoThrow(try builder.asURLRequest()) { (request: URLRequest) in
            XCTAssertNotNil(request)
            XCTAssertEqual(request.httpMethod, "GET")
            XCTAssertNotNil(request.url?.absoluteString.range(of:baseURL))
            XCTAssertNotNil(request.url?.absoluteString.range(of:path))
            XCTAssertEqual(request.url?.query, "userId=12")
        }
    }
    
    func testRequestBuilderInitWithPathMethodParams() {
        // Given
        let baseURL = "hhtps://test.com"
        let path = "login"
        let params = ["userId" : "12"]
        
        // When
        var builder = RestRequestBuilder(path: path, method: .post, params: params)
        builder.baseURLString = baseURL
        
        // Then
        XCTAssertNoThrow(try builder.asURLRequest()) { (request: URLRequest) in
            XCTAssertNotNil(request)
            XCTAssertEqual(request.httpMethod, "POST")
            XCTAssertNotNil(request.url?.absoluteString.range(of:baseURL))
            XCTAssertNotNil(request.url?.absoluteString.range(of:path))
            XCTAssertNotNil(request.httpBody, "HTTPBody should not be nil")
            
            if let httpBody = request.httpBody {
                let datsString = NSString(data: httpBody, encoding: String.Encoding.utf8.rawValue)
                XCTAssertEqual(datsString, "userId=12")
            }
        }
    }
}

class ObjectRequestBuilderTest: BaseTestCase {
    func testRequestBuilderInitWithPathObject() {
        // Given
        let baseURL = "hhtps://test.com"
        let path = "login"
        let product = Product(productId: 12,
                              productName: "some text",
                              imageURL: "http://images.com/skdm732.img")

        // When
        var builder = ObjectRequestBuilder(path: path, object: product)
        builder.baseURLString = baseURL
        
        // Then
        XCTAssertNoThrow(try builder.asURLRequest()) { (request: URLRequest) in
            XCTAssertNotNil(request)
            XCTAssertEqual(request.httpMethod, "POST")
            XCTAssertNotNil(request.url?.absoluteString.range(of:baseURL))
            XCTAssertNotNil(request.url?.absoluteString.range(of:path))
            XCTAssertNotNil(request.httpBody, "HTTPBody should not be nil")
            
            if let httpBody = request.httpBody {
                do {
                    let json = try JSONSerialization.jsonObject(with: httpBody, options: .allowFragments)
                    
                    let stubbedJSON: [String: Any] = [
                        "productId": product.productId,
                        "productName": product.productName,
                        "imageURL": product.imageURL,
                        ]

                    if let json = json as? NSObject {
                        XCTAssertEqual(json, stubbedJSON as NSObject)
                    } else {
                        XCTFail("json should be an NSObject")
                    }
                } catch {
                    XCTFail("json should not be nil")
                }
            }
        }
    }
}
