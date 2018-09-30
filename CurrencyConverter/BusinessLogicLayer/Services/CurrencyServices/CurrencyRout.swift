//
//  CurrencyRout.swift
//  CurrencyConverter
//
//  Created by Tayphoon on 08/09/2018.
//  Copyright © 2018 Tayphoon. All rights reserved.
//

import Foundation

enum CurrencyRout {
    case rates(_ currency: String)
    
    func builder() -> RequestBuilder {
        var builder: RequestBuilder
        
        switch self {
        case .rates(let currency):
            let params = ["base" : currency]
            builder = RestRequestBuilder(path: "latest", params: params)
        }
        
        return builder
    }
}
