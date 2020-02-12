//
//  URLComponents+ExtensionsTests.swift
//  RedditNetworkingTests
//
//  Created by Artem Belenkov on 12/02/2020.
//  Copyright © 2020 Artem Belenkov. All rights reserved.
//

import XCTest
@testable import RedditNetworking

class URLComponentsExtensionsTests: XCTestCase {
    var testObject: URLComponents!
    
    override func tearDown() {
        testObject = nil
        
        super.tearDown()
    }

    func testURLComponents() {
        let schema = "http"
        let host = "testHost"
        let path = "test/Path"
        let items = ["test": "item"]
        
        testObject = URLComponents.construct(schema, host, path, items)
        XCTAssertNotNil(testObject)
        XCTAssertEqual(testObject.scheme, schema)
        XCTAssertEqual(testObject.host, host)
        XCTAssertEqual(testObject.path, path)
        XCTAssertEqual(testObject.queryItems?.count, 1)
    }
}
