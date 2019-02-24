//
//  APIEndPoint.swift
//  Revolut
//
//  Created by Elene Akhvlediani on 11/17/18.
//  Copyright © 2018 Elene Akhvlediani. All rights reserved.
//

import Foundation
import Alamofire

protocol APIEndpoint: URLRequestConvertible {
    var baseURLString: String { get }
    var parameters: [String: Any] { get }
    var method: HTTPMethod { get }
    var path: String { get }
    var apiKey: String { get }
    var parametersEncoding: ParameterEncoding { get }
}

extension APIEndpoint {
    var parametersEncoding: ParameterEncoding { return URLEncoding.default }
    var apiKey: String { return "38fe2c20f7a54380fdb35425f0a317b9" }
    func asURLRequest() throws -> URLRequest {
        let baseUrl = try baseURLString.asURL()
        var urlRequest = URLRequest(url: baseUrl.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue
        return try parametersEncoding.encode(urlRequest, with: parameters)
    }
}
