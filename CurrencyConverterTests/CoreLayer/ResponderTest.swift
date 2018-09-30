//
//  ResponderTest.swift
//  CurrencyConverterTests
//
//  Created by Tayphoon on 30/09/2018.
//  Copyright © 2018 Tayphoon. All rights reserved.
//

import XCTest
import UIKit
@testable import CurrencyConverter

protocol TestActions: class {
    
}

class TestViewWithActions: UIView {
    
    weak var actionProxy: TestActions?
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        
        actionProxy = proxy()
    }
}

class TesController: UIViewController, TestActions {
    
    var testView: TestViewWithActions!
    
    override func viewDidLoad() {
        
        testView = TestViewWithActions()
        self.view.addSubview(testView)
    }
}

class ResponderTest: BaseTestCase {
    
    func testObtainRates() {
        
        // Given
        let controller = TesController()
        _ = controller.view
        
        // Then
        XCTAssertNotNil(controller.testView)
        XCTAssertNotNil(controller.testView.actionProxy)
    }
}
