//
//  RedditTopicDataSource.swift
//  Reddit_test
//
//  Created by Artem Belenkov on 11/02/2020.
//  Copyright © 2020 Artem Belenkov. All rights reserved.
//

import UIKit

class RedditTopicDataSource {
    var sections: [RedditTopicSection] = []
}

class RedditTopicSection {
    var cells: [RedditTopicModel] = []
}

struct RedditTopicModel {
    let title: String
    let author: String
    let created: TimeInterval
    let commentsNumber: Int
    let score: Int
    let name: String
    
    let thumbnailURL: String
    let previewURL: String
}
