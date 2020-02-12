//
//  NetworkingManagerTests.swift
//  RedditNetworkingTests
//
//  Created by Artem Belenkov on 12/02/2020.
//  Copyright © 2020 Artem Belenkov. All rights reserved.
//

import XCTest
@testable import RedditCommon
@testable import RedditNetworking

class NetworkingManagerTests: XCTestCase {
    var testObject: NetworkingManager!
    var testNetworkSession: TestNetworkSession!
    var testReachability: TestReachability!
    var testTasksHolder: TestDataTasksHolder!
    
    override func setUp() {
        super.setUp()
        
        testNetworkSession = TestNetworkSession()
        testReachability = TestReachability()
        testTasksHolder = TestDataTasksHolder()
        testObject = NetworkingManager(session: testNetworkSession,
                                       syncQueue: .main,
                                       tasksHolder: testTasksHolder,
                                       reachability: testReachability)
    }

    override func tearDown() {
        testObject = nil
        testNetworkSession = nil
        testReachability = nil
        testTasksHolder = nil
        
        super.tearDown()
    }

    func testNotReachableError() {
        testReachability.connection = .unavailable
        
        var successWasCalled = false
        let successBlock = BlockObject<TestResponse, Void> { _ in
            successWasCalled = true
        }
        var errorWasCalled: Error?
        let errorBlock = BlockObject<Error, Void> { error in
            errorWasCalled = error
        }
        
        let finishExpectation = expectation(for: NSPredicate(value: true), evaluatedWith: errorWasCalled, handler: nil)
        let task = testObject.sendGetRequest(request: TestRequest(), successBlock: successBlock, errorBlock: errorBlock)
        XCTAssertNil(testTasksHolder.taskAddWasCalled)
        
        wait(for: [finishExpectation], timeout: 5.0)
        
        XCTAssertNil(task)
        XCTAssertTrue((errorWasCalled as? NetworkingError) == NetworkingError.noConnection)
        XCTAssertFalse(successWasCalled)
    }
    
    func testWrongURLError() {
        var successWasCalled = false
        let successBlock = BlockObject<TestResponse, Void> { _ in
            successWasCalled = true
        }
        var errorWasCalled: Error?
        let errorBlock = BlockObject<Error, Void> { error in
            errorWasCalled = error
        }
        
        var request = TestRequest()
        request.host = "//"
        request.path = "...."
        let finishExpectation = expectation(for: NSPredicate(value: true), evaluatedWith: errorWasCalled, handler: nil)
        let task = testObject.sendGetRequest(request: request, successBlock: successBlock, errorBlock: errorBlock)
        XCTAssertNil(testTasksHolder.taskAddWasCalled)
        
        testNetworkSession.completionToTest?(nil, nil, TestError.someError)
        wait(for: [finishExpectation], timeout: 5.0)
        
        XCTAssertNil(task)
        XCTAssertTrue((errorWasCalled as? NetworkingError) == NetworkingError.wrongURL)
        XCTAssertFalse(successWasCalled)
    }
    
    func testInternalError() {
        var successWasCalled = false
        let successBlock = BlockObject<TestResponse, Void> { _ in
            successWasCalled = true
        }
        var errorWasCalled: Error?
        let errorBlock = BlockObject<Error, Void> { error in
            errorWasCalled = error
        }
        
        let request = TestRequest()
        let finishExpectation = expectation(for: NSPredicate(value: true), evaluatedWith: errorWasCalled, handler: nil)
        let task = testObject.sendGetRequest(request: request, successBlock: successBlock, errorBlock: errorBlock)
        XCTAssertNotNil(testTasksHolder.taskAddWasCalled)
        
        testNetworkSession.completionToTest?(nil, nil, TestError.someError)
        wait(for: [finishExpectation], timeout: 5.0)
        
        XCTAssertNotNil(task)
        XCTAssertTrue((errorWasCalled as? NetworkingError) == NetworkingError.dataTaskError(TestError.someError))
        XCTAssertFalse(successWasCalled)
        
    }
    
    func testSucceedRequest() {
        var successWasCalled = false
        let successBlock = BlockObject<TestResponse, Void> { _ in
            successWasCalled = true
        }
        var errorWasCalled: Error?
        let errorBlock = BlockObject<Error, Void> { error in
            errorWasCalled = error
        }
        
        let request = TestRequest()
        let finishExpectation = expectation(for: NSPredicate(value: true), evaluatedWith: successWasCalled, handler: nil)
        let task = testObject.sendGetRequest(request: request, successBlock: successBlock, errorBlock: errorBlock)
        XCTAssertNotNil(testTasksHolder.taskAddWasCalled)
        
        testNetworkSession.completionToTest?("test".data(using: .utf8), HTTPURLResponse.testResponse(code: 200), nil)
        wait(for: [finishExpectation], timeout: 5.0)
        
        XCTAssertNotNil(task)
        XCTAssertNil(errorWasCalled)
        XCTAssertTrue(successWasCalled)
        
    }
}
