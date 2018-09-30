//
//  Array+Sort.swift
//  CurrencyConverter
//
//  Created by Tayphoon on 16/09/2018.
//  Copyright © 2018 Tayphoon. All rights reserved.
//

import Foundation

extension Array where Element: Equatable {
    
    func sorted(by preferredOrder: [Element]) -> [Element] {
        
        return self.sorted { (a, b) -> Bool in
            guard let first = preferredOrder.index(of: a) else {
                return false
            }
            
            guard let second = preferredOrder.index(of: b) else {
                return true
            }
            
            return first < second
        }
    }
}
