//
//  DataTaskTests.swift
//  RedditNetworkingTests
//
//  Created by Artem Belenkov on 12/02/2020.
//  Copyright © 2020 Artem Belenkov. All rights reserved.
//

import XCTest
@testable import RedditNetworking
@testable import RedditCommon

class DataTaskTests: XCTestCase {
    let identifier = "testIdentifier"
    let task = URLSession(configuration: URLSessionConfiguration.default).dataTask(with: URL.testURL)
    
    func testDataTask() {
        let dataTask = DataTask(task: task, identifier: identifier, cancelBlock: nil)
        dataTask.resume()
        XCTAssertTrue(task.state == .running)
    }
    
    func testDataTaskCancel() {
        var cancelCalled = false
        let cancelBlock = EmptyBlock {
            cancelCalled = true
        }
        let dataTask = DataTask(task: task, identifier: identifier, cancelBlock: cancelBlock)
        dataTask.cancel()
        
        XCTAssertTrue(task.state == .canceling)
        XCTAssertTrue(cancelCalled)
    }
}
