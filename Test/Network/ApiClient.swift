//
//  ApiClient.swift
//  Revolut
//
//  Created by Elene Akhvlediani on 11/17/18.
//  Copyright © 2018 Elene Akhvlediani. All rights reserved.
//

import Foundation
import Alamofire

class APIClient {
    
    struct EmptyResult: Decodable { }
    
    let sessionManager: Alamofire.SessionManager
    
    init(sessionManager: Alamofire.SessionManager) {
        self.sessionManager = sessionManager
//        sessionManager.
    }
    
    func performRequest<T: Decodable>(urlRequest: URLRequestConvertible,
                                      parser: @escaping (Data) throws -> T,
                                      completion: @escaping (Result<T>) -> Void) {
        sessionManager
            .request(urlRequest)
            .responseData { (responseData) in
                switch responseData.result {
                case .success(let data):
                    do {
                        let parsedResult = try parser(data)
                        completion(.success(parsedResult))
                    } catch {
                        completion(.failure(error))
                    }
                case .failure(let error):
                    completion(.failure(error))
                }
        }
        
    }
}
