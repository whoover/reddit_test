//
//  RedditTopicModel.swift
//  Reddit_test
//
//  Created by Artem Belenkov on 12.02.2020.
//  Copyright © 2020 Artem Belenkov. All rights reserved.
//

import Foundation

struct RedditTopicModel: Codable {
    let title: String
    let author: String
    let created: TimeInterval
    let commentsNumber: Int
    let score: Int
    let name: String
    
    let thumbnailURL: String
    let previewURL: String?
}
