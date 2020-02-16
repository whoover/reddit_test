//
//  RedditTopicWithoutImageCell.swift
//  Reddit_test
//
//  Created by Artem Belenkov on 14/02/2020.
//  Copyright © 2020 Artem Belenkov. All rights reserved.
//

import UIKit

final class RedditTopicWithoutImageCell: RedditTopicBaseCell {
    override func setupSubviews() {
        super.setupSubviews()
        
        topLabel.topToSuperView(offset: Layout.TopLabel.top)
        topLabel.leftToSuperView(offset: Layout.TopLabel.left)
        topLabel.rightToSuperView(offset: Layout.TopLabel.right)
        topLabel.bottomToTop(view: titleLabel, offset: Layout.TopLabel.bottom)

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
    
    override func configure(_ cellModel: CellModelProtocol, _ delegate: Any?) {
        super.configure(cellModel, delegate)
        
        guard let cellModel = cellModel as? RedditTopicCellModel else {
            return
        }
        
        topLabel.text = "\(cellModel.author.text as? String ?? "") \(cellModel.time.text as? String ?? "")"
    }
}
