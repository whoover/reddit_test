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
    class ServiceLocatorMock: NetworkSessionServiceLocator & URLTaskProcessorServiceLocator & DataTasksHolderServiceLocator & ReachabilityServiceLocator {
        let networkSessionMock = TestNetworkSession()
        func networkSession() -> NetworkSessionProtocol {
            networkSessionMock
        }
        
        let taskProcessorMock = TestURLTaskProcessor()
        func taskProcessor(session: NetworkSessionProtocol) -> URLTaskProcessorProtocol {
            taskProcessorMock
        }
        
        let dataTasksHolderMock = TestDataTasksHolder()
        func dataTasksHolder() -> DataTasksHolderProtocol {
            dataTasksHolderMock
        }
        
        let reachabilityMock = TestReachability.self
        func reachabilityService() -> ReachabilityProtocol.Type {
            reachabilityMock
        }
    }
    
    var testObject: NetworkingManager!
    var serviceLocator: ServiceLocatorMock!
    
    override func setUp() {
        super.setUp()
        
        serviceLocator = ServiceLocatorMock()
        serviceLocator.reachabilityMock.isReachable = true
        testObject = NetworkingManager(serviceLocator: serviceLocator, syncQueue: .main)
    }

    override func tearDown() {
        testObject = nil
        serviceLocator.reachabilityMock.isReachable = true
        serviceLocator = nil
        
        super.tearDown()
    }

    func testNotReachableError() {
        serviceLocator.reachabilityMock.isReachable = false
        
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
        XCTAssertNil(serviceLocator.dataTasksHolderMock.taskAddWasCalled)
        
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
        XCTAssertNil(serviceLocator.dataTasksHolderMock.taskAddWasCalled)
        
        serviceLocator.networkSessionMock.completionToTest?(nil, nil, TestError.someError)
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
        
        serviceLocator.taskProcessorMock.errorToReturn = TestError.someError
        let request = TestRequest()
        let finishExpectation = expectation(for: NSPredicate(value: true), evaluatedWith: errorWasCalled, handler: nil)
        let task = testObject.sendGetRequest(request: request, successBlock: successBlock, errorBlock: errorBlock)
        XCTAssertNotNil(serviceLocator.dataTasksHolderMock.taskAddWasCalled)
        
        wait(for: [finishExpectation], timeout: 5.0)
        
        XCTAssertNotNil(task)
        XCTAssertTrue((errorWasCalled as? TestError) == TestError.someError)
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
        serviceLocator.taskProcessorMock.dataForResponse = "test".data(using: .utf8)
        let finishExpectation = expectation(for: NSPredicate(value: true), evaluatedWith: successWasCalled, handler: nil)
        let task = testObject.sendGetRequest(request: request, successBlock: successBlock, errorBlock: errorBlock)
        XCTAssertNotNil(serviceLocator.dataTasksHolderMock.taskAddWasCalled)
        
        wait(for: [finishExpectation], timeout: 5.0)
        
        XCTAssertNotNil(task)
        XCTAssertNil(errorWasCalled)
        XCTAssertTrue(successWasCalled)
    }
}
