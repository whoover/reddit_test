//
//  TestNetworkSession.swift
//  RedditNetworkingTests
//
//  Created by Artem Belenkov on 12/02/2020.
//  Copyright © 2020 Artem Belenkov. All rights reserved.
//

import UIKit
@testable import RedditNetworking
@testable import RedditCommon

class TestNetworkSession: NetworkSessionProtocol {
    var completionToTest: ((Data?, URLResponse?, Error?) -> Void)?
    func networkingDataTask(with url: URL,
                            identifier: String,
                            completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void,
                            cancelBlock: EmptyBlock) -> DataTaskProtocol {
        completionToTest = completionHandler
        return TestDataTask(identifier: identifier, cancelBlock: cancelBlock)
    }
}
