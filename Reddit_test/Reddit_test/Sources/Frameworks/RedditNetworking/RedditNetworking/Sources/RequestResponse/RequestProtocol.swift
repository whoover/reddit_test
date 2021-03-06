//
//  RequestProtocol.swift
//  Reddit_test
//
//  Created by Artem Belenkov on 11.02.2020.
//  Copyright © 2020 Artem Belenkov. All rights reserved.
//

import UIKit

public protocol Requestable {
    var url: URL? { get }
}

public protocol RequestProtocol: Requestable {
    var schema: String { get }
    var host: String { get }
    var path: String { get }
    var parameters: [String: String?] { get }
}

public extension RequestProtocol {
    var urlComponents: URLComponents {
        URLComponents.construct(schema, host, path, parameters)
    }
    
    var url: URL? {
        urlComponents.url
    }
}
