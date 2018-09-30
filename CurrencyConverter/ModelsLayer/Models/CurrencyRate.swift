//
//  CurrencyRate.swift
//  CurrencyConverter
//
//  Created by Tayphoon on 08/09/2018.
//  Copyright © 2018 Tayphoon. All rights reserved.
//

import Foundation

struct CurrencyRate: Codable {
    
    let currency: String
    let rate: Double
}

extension CurrencyRate: Equatable {
    
    public static func == (lhs: CurrencyRate, rhs: CurrencyRate) -> Bool {
        return lhs.currency == rhs.currency
    }
}
