//
//  CurrencyConverterPresenter.swift
//  CurrencyConverter
//
//  Created by Tayphoon on 19/08/2018.
//  Copyright 2018 Tayphoon. All rights reserved.
//

import Foundation
import Alamofire

/**
 *  Presenter 
 *	
 */
class CurrencyConverterPresenter {

    private var selectedCurrency: Currency!

	weak var view: CurrencyConverterViewInput?
	var interactor: CurrencyConverterInteractorInput?
    var scheduler: TaskRepeater!
    var reachability: Reachability!

    // MARK: - Private methods
    
    private func startUpdateCurrencies() {
        if reachability.isReachable {
            scheduler.resume()
        }
    }
    
    private func stopUpdateCurrencies() {
        scheduler.suspend()
    }

    private func updateCurrencies() {
        interactor?.currencies(for: selectedCurrency, completion: { [weak self] (currencies: [Currency]?, error: Error?) in
            guard let strongSelf = self else {
                return
            }
            
            if let currencies = currencies {
                var result = currencies
                result.insert(strongSelf.selectedCurrency, at: 0)
                strongSelf.view?.configureView(with: result)
            }
        })
    }
    
    private func updateView(for currency: Currency) {
        if let currencies = interactor?.tryCalculateCurrencies(for: currency) {
            var result = currencies
            result.insert(currency, at: 0)
            view?.configureView(with: result)
        }
    }
}

extension CurrencyConverterPresenter: CurrencyConverterViewOutput {
    
    func setupView() {
        
        selectedCurrency = interactor?.defaultCurrency()
        scheduler.eventHandler = { [weak self] in
            guard let strongSelf = self else {
                return
            }

            strongSelf.updateCurrencies()
        }
        
        self.updateCurrencies()
        
        reachability.startListen()
        reachability.whenReachable = { [weak self] reachability in
            guard let strongSelf = self else {
                return
            }

            strongSelf.view?.setNoConnectionLostLable(false)
            strongSelf.startUpdateCurrencies()
        }
        
        reachability.whenUnreachable = { [weak self] reachability in
            guard let strongSelf = self else {
                return
            }

            strongSelf.view?.setNoConnectionLostLable(true)
            strongSelf.stopUpdateCurrencies()
        }
    }
    
    func didSelect(_ currency: Currency) {
        interactor?.updateRates(new: currency, old: selectedCurrency)

        selectedCurrency = currency
        view?.moveCurrencyToTop(currency: currency)
        view?.scrollToTop()
        view?.makeFirstCellAsFirstResponder()
    }
    
    func didUpdateCurrency(_ value: Double?) {
        selectedCurrency.value = value
        updateView(for: selectedCurrency)
    }
}
