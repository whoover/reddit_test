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
    var dataTasks: [TestDataTask]!
    
    override func setUp() {
        super.setUp()
        
        dataTasks = []
        for i in 0...5 {
            dataTasks.append(TestDataTask(identifier: "\(i)", cancelBlock: EmptyBlock {}))
        }
        testObject = DataTasksHolder()
    }

    override func tearDown() {
        testObject = nil
        dataTasks = nil
        
        super.tearDown()
    }

    func testHolderAdding() {
        dataTasks.forEach { testObject.add($0) }
        XCTAssertTrue(testObject.dataTasks.count == dataTasks.count)
    }
    
    func testHolderRemoving() {
        dataTasks.forEach { testObject.add($0) }
        for (index, task) in dataTasks.enumerated() {
            let currentCount = dataTasks.count - index - 1
            testObject.remove(task.identifier)
            XCTAssertTrue(testObject.dataTasks.count == currentCount)
        }
    }
    
    func testHolderCanceling() {
        dataTasks.forEach { testObject.add($0) }
        for (index, task) in dataTasks.enumerated() {
            let currentCount = dataTasks.count - index - 1
            let taskInHolder = testObject.dataTasks[task.identifier]
            testObject.cancel(task.identifier)
            XCTAssertTrue(testObject.dataTasks.count == currentCount)
            XCTAssertTrue(taskInHolder?.isCanceled == true)
        }
    }
    
    func testHolderAllCanceling() {
        dataTasks.forEach { testObject.add($0) }
        testObject.cancelAll()
        XCTAssertTrue(testObject.dataTasks.isEmpty)
        dataTasks.forEach { XCTAssertTrue($0.isCanceled) }
    }
}
