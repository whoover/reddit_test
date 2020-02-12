//
//  TestDataTasksHolder.swift
//  RedditNetworkingTests
//
//  Created by Artem Belenkov on 12/02/2020.
//  Copyright © 2020 Artem Belenkov. All rights reserved.
//

import Foundation
@testable import RedditCommon
@testable import RedditNetworking

class TestDataTasksHolder: DataTasksHolderProtocol {
    var taskAddWasCalled: DataTaskProtocol?
    func add(_ task: DataTaskProtocol?) {
        taskAddWasCalled = task
    }
    
    var removeIdentifierWasCalled: String = ""
    func remove(_ identifier: String) {
        removeIdentifierWasCalled = identifier
    }
    
    var cancelIdentifierWasCalled: String = ""
    func cancel(_ identifier: String) {
        cancelIdentifierWasCalled = identifier
    }
    
    var cancelAllWasCalled = false
    func cancelAll() {
        cancelAllWasCalled = true
    }
}
