//
//  CurrencyServices.swift
//  CurrencyConverter
//
//  Created by Tayphoon on 08/09/2018.
//  Copyright © 2018 Tayphoon. All rights reserved.
//

import Alamofire

protocol CurrencyServices {
    func rates(for currency: String, completion: @escaping (_ rates: [CurrencyRate]?, _ error: Error?) -> Void)
}
