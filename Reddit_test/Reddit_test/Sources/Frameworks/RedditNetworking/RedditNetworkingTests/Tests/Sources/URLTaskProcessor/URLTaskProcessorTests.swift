//
//  URLTaskProcessorTests.swift
//  RedditNetworkingTests
//
//  Created by Artem Belenkov on 12/02/2020.
//  Copyright © 2020 Artem Belenkov. All rights reserved.
//

import XCTest
@testable import RedditCommon
@testable import RedditNetworking

class URLTaskProcessorTests: XCTestCase {
    var testObject: URLTaskProcessor!
    var testNetworkSession: TestNetworkSession!
    
    override func setUp() {
        super.setUp()
        
        testNetworkSession = TestNetworkSession()
        testObject = URLTaskProcessor(session: testNetworkSession)
    }

    override func tearDown() {
        testObject = nil
        testNetworkSession = nil
        
        super.tearDown()
    }

    func testCancel() {
        var successWasCalled = false
        let successBlock = BlockObject<TestResponse, Void> { _ in
            successWasCalled = true
        }
        var errorWasCalled = false
        let errorBlock = BlockObject<Error, Void> { _ in
            errorWasCalled = true
        }
        var cancelWasCalled = false
        let cancelBlock = EmptyBlock {
            cancelWasCalled = true
        }
        
        let task = testObject.createTask(url: URL.testURL,
                                         identifier: "testIdentifier",
                                         successBlock: successBlock,
                                         errorBlock: errorBlock,
                                         cancelBlock: cancelBlock)
        task.cancel()
        testNetworkSession.completionToTest?("test".data(using: .utf8), nil, nil)
        
        XCTAssertTrue(cancelWasCalled)
        XCTAssertFalse(errorWasCalled)
        XCTAssertFalse(successWasCalled)
    }
    
    func testUnknownError() {
        var successWasCalled = false
        let successBlock = BlockObject<TestResponse, Void> { _ in
            successWasCalled = true
        }
        var errorWasCalled: Error?
        let errorBlock = BlockObject<Error, Void> { error in
            errorWasCalled = error
        }
        var cancelWasCalled = false
        let cancelBlock = EmptyBlock {
            cancelWasCalled = true
        }
        
        let finishExpectation = expectation(for: NSPredicate(value: true), evaluatedWith: errorWasCalled, handler: nil)
        _ = testObject.createTask(url: URL.testURL,
                                  identifier: "testIdentifier",
                                  successBlock: successBlock,
                                  errorBlock: errorBlock,
                                  cancelBlock: cancelBlock)
        testNetworkSession.completionToTest?("test".data(using: .utf8), nil, nil)
        wait(for: [finishExpectation], timeout: 5.0)
        
        XCTAssertFalse(cancelWasCalled)
        XCTAssertTrue((errorWasCalled as? NetworkingError) == NetworkingError.unknown)
        XCTAssertFalse(successWasCalled)
    }
    
    func testSessionError() {
        var successWasCalled = false
        let successBlock = BlockObject<TestResponse, Void> { _ in
            successWasCalled = true
        }
        var errorWasCalled: Error?
        let errorBlock = BlockObject<Error, Void> { error in
            errorWasCalled = error
        }
        var cancelWasCalled = false
        let cancelBlock = EmptyBlock {
            cancelWasCalled = true
        }
        
        let finishExpectation = expectation(for: NSPredicate(value: true), evaluatedWith: errorWasCalled, handler: nil)
        _ = testObject.createTask(url: URL.testURL,
                                  identifier: "testIdentifier",
                                  successBlock: successBlock,
                                  errorBlock: errorBlock,
                                  cancelBlock: cancelBlock)
        testNetworkSession.completionToTest?("test".data(using: .utf8), nil, TestError.someError)
        wait(for: [finishExpectation], timeout: 5.0)
        
        XCTAssertFalse(cancelWasCalled)
        XCTAssertTrue((errorWasCalled as? NetworkingError) == NetworkingError.dataTaskError(TestError.someError))
        XCTAssertFalse(successWasCalled)
    }
    
    func testHTTPResponseError() {
        var successWasCalled = false
        let successBlock = BlockObject<TestResponse, Void> { _ in
            successWasCalled = true
        }
        var errorWasCalled: Error?
        let errorBlock = BlockObject<Error, Void> { error in
            errorWasCalled = error
        }
        var cancelWasCalled = false
        let cancelBlock = EmptyBlock {
            cancelWasCalled = true
        }
        
        let finishExpectation = expectation(for: NSPredicate(value: true), evaluatedWith: errorWasCalled, handler: nil)
        _ = testObject.createTask(url: URL.testURL,
                                  identifier: "testIdentifier",
                                  successBlock: successBlock,
                                  errorBlock: errorBlock,
                                  cancelBlock: cancelBlock)
        testNetworkSession.completionToTest?("test".data(using: .utf8), HTTPURLResponse.testResponse(code: 500), nil)
        wait(for: [finishExpectation], timeout: 5.0)
        
        XCTAssertFalse(cancelWasCalled)
        XCTAssertTrue((errorWasCalled as? NetworkingError) == NetworkingError.response(.server))
        XCTAssertFalse(successWasCalled)
    }
    
    func testSuccessResponseError() {
        var successWasCalled = false
        let successBlock = BlockObject<TestResponse, Void> { _ in
            successWasCalled = true
        }
        var errorWasCalled: Error?
        let errorBlock = BlockObject<Error, Void> { error in
            errorWasCalled = error
        }
        var cancelWasCalled = false
        let cancelBlock = EmptyBlock {
            cancelWasCalled = true
        }
        
        let finishExpectation = expectation(for: NSPredicate(value: true), evaluatedWith: successWasCalled, handler: nil)
        _ = testObject.createTask(url: URL.testURL,
                                  identifier: "testIdentifier",
                                  successBlock: successBlock,
                                  errorBlock: errorBlock,
                                  cancelBlock: cancelBlock)
        testNetworkSession.completionToTest?("test".data(using: .utf8), HTTPURLResponse.testResponse(code: 200), nil)
        wait(for: [finishExpectation], timeout: 5.0)
        
        XCTAssertFalse(cancelWasCalled)
        XCTAssertNil(errorWasCalled)
        XCTAssertTrue(successWasCalled)
    }
}
