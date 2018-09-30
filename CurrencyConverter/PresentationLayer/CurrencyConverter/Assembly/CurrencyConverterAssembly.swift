//
//  CurrencyConverterAssembly.swift
//  CurrencyConverter
//
//  Created by Tayphoon on 19/08/2018.
//  Copyright 2018 Tayphoon. All rights reserved.
//

import UIKit

/**
 *  Assembly
 *	
 */
class CurrencyConverterAssembly {

    static func createModule() -> UIViewController {
        let view = CurrencyConverterController()
        let interactor = CurrencyConverterInteractor()
        let currencyService = CurrencyServicesImpl(ApplicationAssembly.requestScheduler, baseURL: "https://revolut.duckdns.org")
        let presenter = CurrencyConverterPresenter()
        let viewModel = CurrencyConverterViewModel()
        
        viewModel.builder = CurrencyObjectBuilder()
        
        view.output = presenter
        view.viewModel = viewModel;
        
        interactor.currencyServices = currencyService
        
        presenter.view = view
        presenter.interactor = interactor
        presenter.scheduler = TaskRepeater(timeInterval: 1)
        presenter.reachability = Reachability()

        return view
    }
}
