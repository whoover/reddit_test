//
//  NetworkingManagerServiceLocator.swift
//  RedditNetworking
//
//  Created by Artem Belenkov on 11/02/2020.
//  Copyright © 2020 Artem Belenkov. All rights reserved.
//

import UIKit

protocol NetworkingManagerServiceLocator {
    static func networkingManager(session: URLSession, syncQueue: DispatchQueue) -> NetworkingManagerProtocol
}

extension NetworkingManagerServiceLocator {
    static func networkingManager(session: URLSession, syncQueue: DispatchQueue) -> NetworkingManagerProtocol {
        return NetworkingManager(session: session, syncQueue: syncQueue)
    }
}
