//
//  CurrencyConverterViewInput.swift
//  CurrencyConverter
//
//  Created by Tayphoon on 19/08/2018.
//  Copyright 2018 Tayphoon. All rights reserved.
//

import Foundation

protocol CurrencyConverterViewInput : class {
    
    func configureView(with currencies: [Currency])
    
    func moveCurrencyToTop(currency: Currency)
    
    func scrollToTop()

    func makeFirstCellAsFirstResponder()

    func setNoConnectionLostLable(_ visible: Bool)
}
