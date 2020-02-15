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
        thumbnailURLString != nil ?
            RedditTopicCell.self :
            RedditTopicWithoutImageCell.self
    }
    
    static var cellHeight: CGFloat { UITableView.automaticDimension }
    
    let identifier = UUID()
    
    let topLabelText: Label
    let title: Label
    let bottomLabelText: Label
    let thumbnailURLString: String?
    let separatorColor: UIColor
    let fullScreenImageURLString: String?
    
    var hasBigImage: Bool {
        thumbnailURLString?.isEmpty != true
    }
    
    init(topLabelText: Label, title: Label, bottomLabelText: Label, thumbnailURLString: String?, separatorColor: UIColor, fullScreenImageURLString: String?) {
        self.topLabelText = topLabelText
        self.title = title
        self.bottomLabelText = bottomLabelText
        self.thumbnailURLString = thumbnailURLString
        self.separatorColor = separatorColor
        self.fullScreenImageURLString = fullScreenImageURLString
    }
}
