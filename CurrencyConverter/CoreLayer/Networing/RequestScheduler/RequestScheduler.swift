//
//  RequestScheduler.swift
//  Tayphoon
//
//  Created by Tayphoon on 07/01/2018.
//  Copyright © 2018 Tayphoon. All rights reserved.
//

import Alamofire

protocol RequestScheduler {
    
    func execute <T: Decodable> (builder: RequestBuilder, decoder: JSONDecoder, completion: @escaping (_ result: Result<T>) -> Void)
}

extension RequestScheduler {
    
    func execute <T: Decodable> (builder: RequestBuilder, decoder: JSONDecoder = JSONDecoder(), completion: @escaping (_ result: Result<T>) -> Void) {
        execute(builder: builder, decoder: decoder, completion: completion)
    }
}
