//
//  RedditNetworkingTests.swift
//  RedditNetworkingTests
//
//  Created by Artem Belenkov on 11/02/2020.
//  Copyright © 2020 Artem Belenkov. All rights reserved.
//

import XCTest
@testable import RedditNetworking

class HTTPResponseTests: XCTestCase {
    var testObject: HTTPResponse!
    
    override func tearDown() {
        testObject = nil
        super.tearDown()
    }

    func testCorrectResponses() {
        testObject = HTTPResponse(value: 100)
        XCTAssertEqual(testObject, .informational)
        testObject = HTTPResponse(value: 199)
        XCTAssertEqual(testObject, .informational)
        
        testObject = HTTPResponse(value: 200)
        XCTAssertEqual(testObject, .success)
        testObject = HTTPResponse(value: 299)
        XCTAssertEqual(testObject, .success)
        
        testObject = HTTPResponse(value: 300)
        XCTAssertEqual(testObject, .redirection)
        testObject = HTTPResponse(value: 399)
        XCTAssertEqual(testObject, .redirection)
        
        testObject = HTTPResponse(value: 400)
        XCTAssertEqual(testObject, .client)
        testObject = HTTPResponse(value: 499)
        XCTAssertEqual(testObject, .client)
        
        testObject = HTTPResponse(value: 500)
        XCTAssertEqual(testObject, .server)
        testObject = HTTPResponse(value: 599)
        XCTAssertEqual(testObject, .server)
    }
    
    func testIncorrectResponse() {
        testObject = HTTPResponse(value: 0)
        XCTAssertNil(testObject)
        testObject = HTTPResponse(value: 600)
        XCTAssertNil(testObject)
    }
}
