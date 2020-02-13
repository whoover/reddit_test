//
//  AddapterService.swift
//  Reddit_test
//
//  Created by Artem Belenkov on 11/02/2020.
//  Copyright © 2020 Artem Belenkov. All rights reserved.
//

import Foundation

protocol AddapterServiceProtocol {
    func addapt(_ response: RedditResponse) -> [RedditTopicModel]
}

class AddapterService: AddapterServiceProtocol {
    func addapt(_ response: RedditResponse) -> [RedditTopicModel] {
        let topics = response.data.children.map {
            RedditTopicModel(title: $0.data.title,
                             author: $0.data.author,
                             created: $0.data.created_utc,
                             commentsNumber: $0.data.num_comments,
                             score: $0.data.score,
                             name: $0.data.name,
                             thumbnailURL: $0.data.thumbnail,
                             previewURL: $0.data.preview?.images.first?.source.url)
        }
        
        return topics
    }
}
