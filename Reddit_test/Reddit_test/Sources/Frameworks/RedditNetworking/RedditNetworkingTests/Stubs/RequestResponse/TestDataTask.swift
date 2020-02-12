//
//  TestDataTask.swift
//  RedditNetworkingTests
//
//  Created by Artem Belenkov on 12/02/2020.
//  Copyright © 2020 Artem Belenkov. All rights reserved.
//

@testable import RedditNetworking
@testable import RedditCommon

class TestDataTask: DataTaskProtocol {
    var isCanceled: Bool = false
    let identifier: String
    var cancelBlock: EmptyBlock
    
    init(identifier: String = "testIdentifier", cancelBlock: EmptyBlock) {
        self.identifier = identifier
        self.cancelBlock = cancelBlock
    }
    
    var resumeWasCalled = false
    func resume() {
        resumeWasCalled = true
    }
    
    func cancel() {
        isCanceled = true
        cancelBlock.execute(())
    }
}
