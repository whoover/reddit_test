//
//  NetworkingManagerServiceLocator.swift
//  RedditNetworking
//
//  Created by Artem Belenkov on 11/02/2020.
//  Copyright © 2020 Artem Belenkov. All rights reserved.
//

import UIKit

public protocol NetworkingManagerServiceLocator {
    func networkingManager(syncQueue: DispatchQueue) -> NetworkingManagerProtocol
}

extension NetworkingManagerServiceLocator {
    public func networkingManager(syncQueue: DispatchQueue) -> NetworkingManagerProtocol {
        NetworkingManager(syncQueue: syncQueue)
    }
    
    public func networkingManager() -> NetworkingManagerProtocol {
        networkingManager(syncQueue: .main)
    }
}
