//
//  BaseTestCase.swift
//  CurrencyConverterTests
//
//  Created by Tayphoon on 08/09/2018.
//  Copyright © 2018 Tayphoon. All rights reserved.
//

import XCTest

class BaseTestCase: XCTestCase {
    let timeout: TimeInterval = 3.0
    
}

public func XCTAssertNoThrow<T>(_ expression: @autoclosure () throws -> T, _ message: String = "", file: StaticString = #file, line: UInt = #line, also validateResult: (T) -> Void) {
    func executeAndAssignResult(_ expression: @autoclosure () throws -> T, to: inout T?) rethrows {
        to = try expression()
    }
    var result: T?
    XCTAssertNoThrow(try executeAndAssignResult(expression, to: &result), message, file: file, line: line)
    if let r = result {
        validateResult(r)
    }
}
