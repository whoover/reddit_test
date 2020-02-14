//
//  RedditTopicDataSource.swift
//  Reddit_test
//
//  Created by Artem Belenkov on 11/02/2020.
//  Copyright © 2020 Artem Belenkov. All rights reserved.
//

import RedditCommonUI

class RedditTopicDataSource: TableViewDataSourceModelProtocol {
    var sections: [RedditTopicSection] = []
}

class RedditTopicSection: TableViewSectionModelProtocol {
    var cells: [RedditTopicCellModel] = []
}

class RedditTopicCellModel: CellModelProtocol {
    var cellClass: CellProtocol.Type {
        return model.thumbnailURL.contains("http") ? RedditTopicCell.self : RedditTopicWithoutImageCell.self
    }
    
    static var cellHeight: CGFloat { UITableView.automaticDimension }
    
    let model: RedditTopicModel
    let identifier = UUID()
    
    init(model: RedditTopicModel) {
        self.model = model
    }
}
