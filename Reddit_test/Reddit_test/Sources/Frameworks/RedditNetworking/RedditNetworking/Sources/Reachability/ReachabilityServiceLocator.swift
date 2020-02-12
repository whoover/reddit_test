//
//  ReachabilityServiceAssembly.swift
//  RedditNetworking
//
//  Created by Artem Belenkov on 11.02.2020.
//  Copyright © 2020 Artem Belenkov. All rights reserved.
//

public protocol ReachabilityServiceLocator {
    func reachabilityService() -> ReachabilityProtocol.Type
}

extension ReachabilityServiceLocator {
    public func reachabilityService() -> ReachabilityProtocol.Type {
        Reachability.self
    }
}
