//
//  CurrencyConverterViewOutput.swift
//  CurrencyConverter
//
//  Created by Tayphoon on 19/08/2018.
//  Copyright 2018 Tayphoon. All rights reserved.
//
import Foundation

protocol CurrencyConverterViewOutput {
	
    func setupView()
    
    func didSelect(_ currency: Currency)
    
    func didUpdateCurrency(_ value: Double?)
}
