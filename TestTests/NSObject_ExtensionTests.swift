//
//  NSObject_ExtensionTests.swift
//  TestTests
//
//  Created by Elene Akhvlediani on 25/02/2019.
//  Copyright © 2019 Elene Akhvlediani. All rights reserved.
//

import XCTest
@testable import Test

class NSObject_ExtensionTests: XCTestCase {
    func testClassName() {
        XCTAssertEqual(UIView.className, "UIView")
        XCTAssertNotEqual(UIView.className, "UIViews")
        XCTAssertEqual(SearchViewModel.className, "SearchViewModel")
    }
}
