//
//  URLComponents+Extensions.swift
//  Reddit_test
//
//  Created by Artem Belenkov on 10.02.2020.
//  Copyright © 2020 Artem Belenkov. All rights reserved.
//

import Foundation

public extension URLComponents {
    static func construct(_ schema: String,
                          _ host: String,
                          _ path: String,
                          _ queryItems: [String: String?] = [:]) -> URLComponents {
    var components = URLComponents()
    components.scheme = "https"
    components.host = host.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
    components.path = path.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
    var queryItemsToAdd: [URLQueryItem] = []
    queryItems.forEach {
        if let value = $0.value?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
            queryItemsToAdd.append(URLQueryItem(name: $0.key, value: value))
        }
    }
    components.queryItems = queryItemsToAdd
    
    return components
  }
}
