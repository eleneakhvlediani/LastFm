//
//  TestTests.swift
//  TestTests
//
//  Created by Elene Akhvlediani on 11/02/2019.
//  Copyright © 2019 Elene Akhvlediani. All rights reserved.
//

import XCTest
import Alamofire
@testable import Test

class TestTests: XCTestCase {

    let apiEndPointMockRequest = try! ApiEndPointMock().asURLRequest()

    func testURL() {
        XCTAssertEqual(apiEndPointMockRequest.url!.absoluteString, "http://localhost/register")
    }
    
    func testMethod() {
        XCTAssertEqual(apiEndPointMockRequest.httpMethod, "POST")
    }
    
    func testParameters() {
        let data = apiEndPointMockRequest.httpBody
        let dictionary = try! JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? [String: Any]
        XCTAssertEqual(dictionary?["id"] as? Int, 42)
        XCTAssertEqual(dictionary?["booltest"] as? Bool, true)
    }
}

class ApiEndPointMock: APIEndpoint {
    var parameters: [String: Any] = ["id": 42, "booltest": true]
    let method: HTTPMethod = .post
    var path: String = "register"
    let parametersEncoding: ParameterEncoding = JSONEncoding.default
    var baseURLString: String = "http://localhost/"
}
