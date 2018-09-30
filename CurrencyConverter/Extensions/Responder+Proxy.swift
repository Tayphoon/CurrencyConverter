//
//  Responder+Proxy.swift
//  CurrencyConverter
//
//  Created by Tayphoon on 11/09/2018.
//  Copyright © 2018 Tayphoon. All rights reserved.
//

import UIKit

extension UIResponder: Responder {
    
    public var nextResponder: Responder? {
        return next
    }
}

