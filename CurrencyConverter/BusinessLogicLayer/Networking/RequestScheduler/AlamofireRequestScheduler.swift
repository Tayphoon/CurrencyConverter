//
//  AlamofireRequestScheduler.swift
//  Tayphoon
//
//  Created by Tayphoon on 08/01/2018.
//  Copyright © 2018 Tayphoon. All rights reserved.
//

import Foundation
import Alamofire

class AlamofireRequestScheduler: RequestScheduler {
    private let sessionManager: Session = {
        let configuration = URLSessionConfiguration.default
        return Session(configuration: configuration)
    }()
    
    func execute<T: Decodable>(builder: RequestBuilder, decoder: JSONDecoder, completion: @escaping (_ result: Result<T>) -> Void) {

        sessionManager.request(builder).responseJSONDecodable (decoder: decoder) { (response: DataResponse<T>) in
            switch response.result {
            case .failure(let error):
                print(error)
                if let data = response.data, let response = String(data: data, encoding: String.Encoding.utf8) {
                    print(response)
                }
            default:
                break
            }

            completion(response.result)
        }
    }
}
