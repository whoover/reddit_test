//
//  ServiceLocatorsTests.swift
//  RedditNetworkingTests
//
//  Created by Artem Belenkov on 12.02.2020.
//  Copyright © 2020 Artem Belenkov. All rights reserved.
//

import XCTest
@testable import RedditNetworking

class ServiceLocatorsTests: XCTestCase {
    class ServiceLocators: NetworkingManagerServiceLocator & ReachabilityServiceLocator & NetworkSessionServiceLocator & DataTasksHolderServiceLocator & URLTaskProcessorServiceLocator {
        
    }
    
    var testObject: ServiceLocators!
    
    override func setUp() {
        super.setUp()
        
        testObject = ServiceLocators()
    }

    override func tearDown() {
        testObject = nil
        
        super.tearDown()
    }

    func testServiceLocators() {
        var service: Any? = testObject.networkingManager()
        XCTAssertTrue(service is NetworkingManager)
        
        service = testObject.reachabilityService()
        XCTAssertTrue(service is Reachability.Type)
        
        service = testObject.networkSession()
        XCTAssertTrue(service is URLSession)
        
        service = testObject.dataTasksHolder()
        XCTAssertTrue(service is DataTasksHolder)
        
        service = testObject.taskProcessor(session: testObject.networkSession())
        XCTAssertTrue(service is URLTaskProcessor)
    }
}
