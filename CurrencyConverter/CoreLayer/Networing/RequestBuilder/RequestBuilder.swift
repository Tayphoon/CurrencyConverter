//
//  Request.swift
//  Tayphoon
//
//  Created by Tayphoon on 07/01/2018.
//  Copyright © 2018 Tayphoon. All rights reserved.
//

import Alamofire

protocol RequestBuilder : URLRequestConvertible {
    var baseURLString: String { get set }
}
