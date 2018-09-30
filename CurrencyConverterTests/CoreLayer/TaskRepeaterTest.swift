//
//  TaskRepeaterTest.swift
//  CurrencyConverterTests
//
//  Created by Tayphoon on 30/09/2018.
//  Copyright © 2018 Tayphoon. All rights reserved.
//

import XCTest
@testable import CurrencyConverter

class TaskRepeaterTest: BaseTestCase {
    
    func testTaskSchedule() {
        // Given
        let scheduler = TaskRepeater(timeInterval: 1)

        // When
        let expectation = self.expectation(description: "calls scheduler callback")
        scheduler.eventHandler = {
            expectation.fulfill()
        }
        scheduler.resume()
        
        // Then
        self.waitForExpectations(timeout: 1.1, handler: .none)
    }
    
    func testTaskScheduleSuspend() {
        // Given
        let scheduler = TaskRepeater(timeInterval: 1)
        
        // Then
        scheduler.eventHandler = {
            XCTFail("calls callback after scheduler suspended")

        }
        scheduler.resume()
        scheduler.suspend()
    }
}
