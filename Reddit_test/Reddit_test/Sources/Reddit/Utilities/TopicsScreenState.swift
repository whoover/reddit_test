//
//  TopicsScreenState.swift
//  Reddit_test
//
//  Created by Artem Belenkov on 13.02.2020.
//  Copyright © 2020 Artem Belenkov. All rights reserved.
//

import UIKit

enum TopicsScreenState {
    case loading
    case dataLoaded([RedditTopicCellModel])
    case error(Error)
}
