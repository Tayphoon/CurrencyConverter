//
//  Currency.swift
//  CurrencyConverter
//
//  Created by Tayphoon on 08/09/2018.
//  Copyright © 2018 Tayphoon. All rights reserved.
//

import Foundation
import DifferenceKit

struct Currency: Codable {
    
    var name: String
    var flag: String
    var value: Double?
}

extension Currency: Equatable {
    
    public static func == (lhs: Currency, rhs: Currency) -> Bool {
        return lhs.name == rhs.name
    }
}

extension Currency: Differentiable {
    
    var differenceIdentifier: String {
        return name
    }
    
    func isContentEqual(to source: Currency) -> Bool {
        return value == source.value
    }
}
