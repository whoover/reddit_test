//
//  NetworkSessionServiceLocator.swift
//  RedditNetworking
//
//  Created by Artem Belenkov on 12/02/2020.
//  Copyright © 2020 Artem Belenkov. All rights reserved.
//

import UIKit

public protocol NetworkSessionServiceLocator {
    func networkSession() -> NetworkSessionProtocol
}

extension NetworkSessionServiceLocator {
    public func networkSession() -> NetworkSessionProtocol {
        URLSession.shared
    }
}
