//
//  RedditTopicWithoutImageCell.swift
//  Reddit_test
//
//  Created by Artem Belenkov on 14/02/2020.
//  Copyright © 2020 Artem Belenkov. All rights reserved.
//

import UIKit

class RedditTopicWithoutImageCell: RedditTopicBaseCell {
    override func setupSubviews() {
        super.setupSubviews()
        
        author.topToSuperView(offset: Layout.Author.top)
        author.leftToSuperView(offset: Layout.Author.left)
        author.rightToSuperView(offset: Layout.Author.right)
        author.bottomToTop(view: titleLabel, offset: Layout.Author.bottom)
        author.font = Theme.Font.regular.font(size: .small)

        titleLabel.leftToSuperView(offset: Layout.Title.left)
        titleLabel.rightToSuperView(offset: Layout.Title.right)
        titleLabel.bottomToTop(view: bottomLabel, offset: Layout.Title.bottom)
        
        bottomLabel.leftToSuperView(offset: Layout.Title.left)
        bottomLabel.rightToSuperView(offset: Layout.Title.right)
        bottomLabel.bottomToSuperView(offset: Layout.Bottom.bottom, relation: .lessThanOrEqual)
        
        separator.leftToSuperView()
        separator.rightToSuperView()
        separator.bottomToSuperView()
        separator.height(Layout.Separator.height)
        separator.backgroundColor = .lightGray
    }
}
