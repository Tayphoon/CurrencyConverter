//
//  ArraySortTest.swift
//  CurrencyConverterTests
//
//  Created by Tayphoon on 30/09/2018.
//  Copyright © 2018 Tayphoon. All rights reserved.
//

import XCTest
@testable import CurrencyConverter

class ArraySortTest: BaseTestCase {
    
    func testSortInts() {
        
        // Given
        let initialArray = [2, 3, 1, 4, 5]
        let preferredOrder = [2, 1, 3, 4, 5]
        
        // When
        let sorted = initialArray.sorted(by: preferredOrder)
        
        // Then
        XCTAssertEqual(preferredOrder, sorted)
    }
    
    func testSortStrings() {
        
        // Given
        let initialArray = ["Two", "Four", "Three", "One", "Five", "Six"]
        let preferredOrder = ["One", "Two", "Three", "Four", "Five"]
        
        // When
        let sorted = initialArray.sorted(by: preferredOrder)
        
        // Then
        XCTAssertEqual(preferredOrder, Array(sorted.dropLast()))
    }
}
