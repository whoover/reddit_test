//
//  NetworkSessionServiceLocator.swift
//  RedditNetworking
//
//  Created by Artem Belenkov on 12/02/2020.
//  Copyright © 2020 Artem Belenkov. All rights reserved.
//

import UIKit

public protocol NetworkSessionServiceLocator {
    static func networkSession() -> NetworkSessionProtocol
}

extension NetworkSessionServiceLocator {
    public static func networkSession() -> NetworkSessionProtocol {
        return URLSession.shared
    }
}
