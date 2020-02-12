//
//  NetworkingManagerServiceLocator.swift
//  RedditNetworking
//
//  Created by Artem Belenkov on 11/02/2020.
//  Copyright © 2020 Artem Belenkov. All rights reserved.
//

import UIKit

protocol NetworkingManagerServiceLocator {
    static func networkingManager() -> NetworkingManagerProtocol
}

extension NetworkingManagerServiceLocator {
    static func networkingManager() -> NetworkingManagerProtocol {
        return NetworkingManager()
    }
}
