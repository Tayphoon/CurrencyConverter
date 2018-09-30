//
//  ObjectRequestBuilder.swift
//  Tayphoon
//
//  Created by Tayphoon on 21/03/2018.
//  Copyright © 2018 Tayphoon. All rights reserved.
//

import Alamofire

struct ObjectRequestBuilder<T> : RequestBuilder where T: Encodable {
    let path: String
    let method: HTTPMethod
    let object: T
    let encoder: JSONEncoder

    var baseURLString: String = ""

    init(path: String, method: HTTPMethod = .post, object: T, encoder: JSONEncoder = JSONEncoder()) {
        self.path = path
        self.method = method
        self.object = object
        self.encoder = encoder
    }

    func asURLRequest() throws -> URLRequest {
        let url = try baseURLString.asURL()
        var request = URLRequest(url: url.appendingPathComponent(path))
        request.httpMethod = method.rawValue

        let httpBody = try encoder.encode(object)
        request.httpBody = httpBody
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        return request
    }
}
