//
//  RequestProtocol.swift
//  Reddit_test
//
//  Created by Artem Belenkov on 11.02.2020.
//  Copyright © 2020 Artem Belenkov. All rights reserved.
//

import UIKit

protocol RequestProtocol {
    var schema: String { get }
    var host: String { get }
    var path: String { get }
    var parameters: [String: String?] { get }
}

extension RequestProtocol {
    var urlComponents: URLComponents {
        URLComponents.construct(schema, host, path, parameters)
    }
}
