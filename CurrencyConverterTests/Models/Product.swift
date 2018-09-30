//
//  Product.swift
//  StolichkiTests
//
//  Created by Tayphoon on 09/01/2018.
//  Copyright © 2018 Inostudio. All rights reserved.
//

import Foundation
@testable import CurrencyConverter

struct Product: Codable {
    
    var productId: Int = -1
    var productName: String = ""
    var imageURL: String = ""
}
