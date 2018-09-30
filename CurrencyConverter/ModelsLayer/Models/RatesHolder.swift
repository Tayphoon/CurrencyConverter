//
//  RatesHolder.swift
//  CurrencyConverter
//
//  Created by Tayphoon on 08/09/2018.
//  Copyright © 2018 Tayphoon. All rights reserved.
//

import Foundation

struct RatesHolder: Codable {
    
    let base: String
    let rates: [String : Double]
}
