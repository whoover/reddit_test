//
//  NetworkingManagerServiceLocator.swift
//  RedditNetworking
//
//  Created by Artem Belenkov on 11/02/2020.
//  Copyright © 2020 Artem Belenkov. All rights reserved.
//

import UIKit

public protocol NetworkingManagerServiceLocator {
    func networkingManager() -> NetworkingManagerProtocol
}

extension NetworkingManagerServiceLocator {
    public func networkingManager() -> NetworkingManagerProtocol {
        NetworkingManager()
    }
}
