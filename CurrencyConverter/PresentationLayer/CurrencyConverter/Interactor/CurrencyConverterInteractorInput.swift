//
//  CurrencyConverterInteractorInput.swift
//  CurrencyConverter
//
//  Created by Tayphoon on 19/08/2018.
//  Copyright 2018 Tayphoon. All rights reserved.
//

import Foundation

protocol CurrencyConverterInteractorInput {
	
    /**
       Request and store rates for currency, when calculate currency values for `currency` param.
     
       - parameter currency: Currency for calculation and request.
       - parameter completion: The completion handler to call when calculation complete.
       - returns: List of calculated currencies
     */
    func currencies(for currency: Currency, completion: @escaping (_ currencies: [Currency]?,_ error: Error?) -> Void)
    
    /**
       Try to calculate currency values for `currency` and previos stored rates.
       - seealso: `currencies(for currencs, completion)`
     
       - parameter currency: Currency for calculation and request.
       - returns: List of calculated currencies
     */
    func tryCalculateCurrencies(for currency: Currency) -> [Currency]?
    
    
    /** Make default currency
 
       - returns: Currency object
     */
    func defaultCurrency() -> Currency
    
    /** Update rates by currency. Calculate rate for previous currency and insert as first element in list.
        Remove rate associated with `new` currency
     
       - parameter new: Currency for calculation and request.
       - parameter old: Currency for calculation and request.
     */
    func updateRates(new: Currency, old: Currency)
}
