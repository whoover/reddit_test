//
//  TestReachability.swift
//  RedditNetworkingTests
//
//  Created by Artem Belenkov on 12/02/2020.
//  Copyright © 2020 Artem Belenkov. All rights reserved.
//

import Foundation
@testable import RedditCommon
@testable import RedditNetworking

class TestReachability: ReachabilityProtocol {
    static var isReachable = true
    static func isConnectedToNetwork() -> Bool {
        isReachable
    }
}
