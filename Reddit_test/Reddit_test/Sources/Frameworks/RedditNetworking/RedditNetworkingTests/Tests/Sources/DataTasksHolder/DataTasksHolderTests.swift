//
//  DataTasksHolderTests.swift
//  RedditNetworkingTests
//
//  Created by Artem Belenkov on 12/02/2020.
//  Copyright © 2020 Artem Belenkov. All rights reserved.
//

import XCTest
@testable import RedditCommon
@testable import RedditNetworking

class DataTasksHolderTests: XCTestCase {
    var testObject: DataTasksHolder!
    var testTasksHolder: [String: CancellableProtocol]!
    
    override func setUp() {
        super.setUp()
        
        testTasksHolder = [:]
        testObject = DataTasksHolder(dataTasks: testTasksHolder)
    }

    override func tearDown() {
        testObject = nil
        testTasksHolder = nil
        
        super.tearDown()
    }

    func testHolderAdding() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
}
