//
//  RedditResponse.swift
//  Reddit_test
//
//  Created by Artem Belenkov on 11/02/2020.
//  Copyright © 2020 Artem Belenkov. All rights reserved.
//

import RedditNetworking

enum RedditDecoding: Error {
    case noData
}

struct RedditResponse: Codable, ResponseProtocol {
    static func responseObject(_ data: Data?) throws -> RedditResponse {
        guard let data = data else {
            throw RedditDecoding.noData
        }
        
        return try JSONDecoder().decode(self, from: data)
    }
}
