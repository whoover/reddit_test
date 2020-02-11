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
    let data: RedditDataResponse
    
    static func responseObject(_ data: Data?) throws -> RedditResponse {
        guard let data = data else {
            throw RedditDecoding.noData
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
    let preview: RedditTopicPreview
}

struct RedditTopicPreview: Codable {
    let images: [RedditImage]
}

struct RedditImage: Codable {
    let source: RedditImageSource
}

struct RedditImageSource: Codable {
    let url: String
}