//
//  RestRequestBuilder.swift
//  Tayphoon
//
//  Created by Tayphoon on 21/03/2018.
//  Copyright © 2018 Tayphoon. All rights reserved.
//

import Alamofire

struct RestRequestBuilder : RequestBuilder {
    let path: String
    let method: HTTPMethod
    let params: [String : Any]?

    var baseURLString: String = ""

    init(path: String, method: HTTPMethod = .get, params: [String : Any]? = nil) {
        self.path = path
        self.method = method
        self.params = params
    }

    func asURLRequest() throws -> URLRequest {
        let url = try baseURLString.asURL()
        var request = URLRequest(url: url.appendingPathComponent(path))
        request.httpMethod = method.rawValue
        return try URLEncoding.default.encode(request, with: params)
    }
}
