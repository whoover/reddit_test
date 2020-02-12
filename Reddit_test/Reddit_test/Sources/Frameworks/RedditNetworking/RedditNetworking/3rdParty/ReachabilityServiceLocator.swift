//
//  ReachabilityServiceLocator.swift
//  RedditNetworking
//
//  Created by Artem Belenkov on 12/02/2020.
//  Copyright © 2020 Artem Belenkov. All rights reserved.
//

import UIKit

public protocol ReachabilityProtocol {
    var connection: Reachability.Connection { get }
}

extension Reachability: ReachabilityProtocol {}

public protocol ReachabilityServiceLocator {
    static func reachabilityService() throws -> ReachabilityProtocol
}

extension ReachabilityServiceLocator {
    public static func reachabilityService() throws -> ReachabilityProtocol {
        return try Reachability()
    }
}
