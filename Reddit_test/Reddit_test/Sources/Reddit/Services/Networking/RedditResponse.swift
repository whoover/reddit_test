//
//  RedditResponse.swift
//  Reddit_test
//
//  Created by Artem Belenkov on 11/02/2020.
//  Copyright © 2020 Artem Belenkov. All rights reserved.
//

import RedditNetworking

struct RedditResponse: Codable, ResponseProtocol {
    let data: RedditDataResponse
    
    static func responseObject(_ data: Data?, _ response: HTTPURLResponse) throws -> RedditResponse {
        guard let data = data else {
            throw DataError.noData
        }
        
        return try JSONDecoder().decode(self, from: data)
    }
}

struct RedditDataResponse: Codable {
    let children: [RedditTopicResponse]
    let after: String?
}

struct RedditTopicResponse: Codable {
    let data: RedditTopicData
}

struct RedditTopicData: Codable {
    let title: String
    let author: String
    let created_utc: TimeInterval
    let thumbnail: String
    let num_comments: Int
    let score: Int
    let name: String
    let url: String?
}
