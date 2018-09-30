//
//  CurrencyServicesImpl.swift
//  CurrencyConverter
//
//  Created by Tayphoon on 08/09/2018.
//  Copyright © 2018 Tayphoon. All rights reserved.
//

import Alamofire

class CurrencyServicesImpl {
    private var baseURL: String
    private var requestSheduler: RequestScheduler
    
    init(_ sheduler: RequestScheduler, baseURL: String) {
        self.baseURL = baseURL;
        self.requestSheduler = sheduler
    }
}

extension CurrencyServicesImpl: CurrencyServices {
    
    func rates(for currency: String, completion: @escaping (_ rates: [CurrencyRate]?, _ error: Error?) -> Void) {
        var builder = CurrencyRout.rates(currency).builder()
        builder.baseURLString = baseURL;
        
        requestSheduler.execute(builder: builder) { (result: Result<RatesHolder>) in
            switch result {
            case .success(let result):
                let rates = result.rates.map { CurrencyRate(currency: $0.key, rate: $0.value) }
                completion(rates, nil)

            case .failure(let error):
                completion(nil, error)
            }
        }
    }
}
