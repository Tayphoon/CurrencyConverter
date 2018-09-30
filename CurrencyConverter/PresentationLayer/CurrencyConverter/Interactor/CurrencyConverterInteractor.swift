//
//  CurrencyConverterInteractor.swift
//  CurrencyConverter
//
//  Created by Tayphoon on 19/08/2018.
//  Copyright 2018 Tayphoon. All rights reserved.
//

import Foundation
import IsoCountryCodes

/**
 *  Interactor 
 *	
 */
class CurrencyConverterInteractor {
    
    var currencyServices: CurrencyServices!
    var rates: [CurrencyRate]?
    
    // MARK: - Private methods
    
    func sortIfNeed(rates: [CurrencyRate]) -> [CurrencyRate] {
        guard let orderedRates = self.rates else {
            return rates
        }
        
        return rates.sorted(by: orderedRates)
    }

    private func flagCode(currency: String) -> String {
        
        if currency == "EUR" {
            return "🇪🇺"
        }
        
        if currency == "USD" {
            return "🇺🇸"
        }
        
        if currency == "GBP" {
            return "🇬🇧"
        }
        
        if let countryInfo = IsoCountryCodes.searchByCurrency(currency: currency).first {
            return countryInfo.flag
        }
        else {
            return "🏳️"
        }
    }
}

extension CurrencyConverterInteractor: CurrencyConverterInteractorInput {

    func currencies(for currency: Currency, completion: @escaping (_ currencies: [Currency]?,_ error: Error?) -> Void) {
        currencyServices.rates(for: currency.name) { [weak self] (rates: [CurrencyRate]?, error: Error?) in
            guard let strongSelf = self else {
                return
            }

            if let rates = rates, rates.count > 0 {
                let sortedRates = strongSelf.sortIfNeed(rates: rates)
                strongSelf.rates = sortedRates
                
                let currencies = sortedRates.map {
                    return strongSelf.makeCurrency(for: $0, currency: currency)
                }
                completion(currencies, nil)
            }
            else {
                completion(nil, error)
            }
        }
    }
    
    func tryCalculateCurrencies(for currency: Currency) -> [Currency]? {
        if let rates = rates {
            let currencies = rates.map {
                return makeCurrency(for: $0, currency: currency)
            }
            return currencies
        }
        
        return nil
    }
    
    func makeCurrency(for rate: CurrencyRate, currency: Currency) -> Currency {
        var value: Double?
        if let currencyValue = currency.value {
            value = rate.rate * currencyValue
        }
        
        return Currency(name: rate.currency,
                        flag: flagCode(currency: rate.currency),
                        value: value)
    }
    
    func defaultCurrency() -> Currency {
        let currency = "EUR"
        return Currency(name: currency, flag:flagCode(currency: currency), value: 100)
    }
    
    func updateRates(new: Currency, old: Currency) {
        guard var rates = rates else {
            return
        }
        
        if let index = rates.firstIndex(where: { $0.currency == new.name }) {
            rates.remove(at: index)
        }
        
        let oldValue = old.value ?? 0
        let newValue = new.value ?? 0
        let rate = CurrencyRate(currency: old.name, rate: newValue / oldValue )
        
        rates.insert(rate, at: 0)
        self.rates = rates
    }
}
