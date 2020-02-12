//
//  TestDataTask.swift
//  RedditNetworkingTests
//
//  Created by Artem Belenkov on 12/02/2020.
//  Copyright © 2020 Artem Belenkov. All rights reserved.
//

@testable import RedditNetworking

class TestDataTask: DataTaskProtocol {
    var isCanceled: Bool = false
    let identifier: String
    
    init(identifier: String = "testIdentifier") {
        self.identifier = identifier
    }
    
    var resumeWasCalled = false
    func resume() {
        resumeWasCalled = true
    }
    
    func cancel() {
        isCanceled = true
    }
}
