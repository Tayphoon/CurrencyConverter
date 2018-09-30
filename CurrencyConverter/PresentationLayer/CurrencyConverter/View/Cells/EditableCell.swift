//
//  CurrencyCell.swift
//  CurrencyConverter
//
//  Created by Tayphoon on 16/09/2018.
//  Copyright © 2018 Tayphoon. All rights reserved.
//

import Collections

protocol EditableCell {
    
    var editable: Bool { get set}
    
    func becomeFirstResponder()
}
