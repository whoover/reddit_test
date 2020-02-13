//
//  CellBottomView.swift
//  Reddit_test
//
//  Created by Artem Belenkov on 13.02.2020.
//  Copyright © 2020 Artem Belenkov. All rights reserved.
//

import UIKit

class CellBottomView: UIView {
    let leftRagingArrow = UIImageView()
    let ratingInfoLabel = UILabel()
    let rightRatingArrow = UIImageView()
    let commentImageView = UIImageView()
    let commentsCountLabel = UILabel()
    let publicationDateLabel = UILabel()
    
    private struct Layout {
        static let topOffset: CGFloat = 4
        static let bottomOffset: CGFloat = -4
        
        struct LeftArrow {
            static let left: CGFloat = 4
        }
        struct Rating {
            static let left: CGFloat = 4
        }
        struct RightArrow {
            static let left: CGFloat = 4
        }
        struct CommentIcon {
            static let left: CGFloat = 30
        }
        struct CommentLabel {
            static let left: CGFloat = 4.0
            static let right: CGFloat = 4.0
        }
        struct Date {
            static let right: CGFloat = -4.0
        }
    }
    
    init() {
        super.init(frame: .zero)
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSubviews() {
        translatesAutoresizingMaskIntoConstraints = false
        addSubview(leftRagingArrow)
        leftRagingArrow.image = UIImage(named: "top_arrow")
        addSubview(ratingInfoLabel)
        addSubview(rightRatingArrow)
        rightRatingArrow.image = UIImage(named: "bottom_arrow")
        addSubview(commentImageView)
        commentImageView.image = UIImage(named: "comments")
        addSubview(commentsCountLabel)
        addSubview(publicationDateLabel)
        
        leftRagingArrow.topToSuperView(offset: Layout.topOffset)
        ratingInfoLabel.topToSuperView(offset: Layout.topOffset)
        rightRatingArrow.topToSuperView(offset: Layout.topOffset)
        commentImageView.topToSuperView(offset: Layout.topOffset)
        commentsCountLabel.topToSuperView(offset: Layout.topOffset)
        publicationDateLabel.topToSuperView(offset: Layout.topOffset)
        
        leftRagingArrow.bottomToSuperView(offset: Layout.bottomOffset)
        ratingInfoLabel.bottomToSuperView(offset: Layout.bottomOffset)
        rightRatingArrow.bottomToSuperView(offset: Layout.bottomOffset)
        commentImageView.bottomToSuperView(offset: Layout.bottomOffset)
        commentsCountLabel.bottomToSuperView(offset: Layout.bottomOffset)
        publicationDateLabel.bottomToSuperView(offset: Layout.bottomOffset)
        
        leftRagingArrow.leftToSuperView(offset: Layout.LeftArrow.left)
        ratingInfoLabel.leftToRight(view: leftRagingArrow, offset: Layout.Rating.left)
        rightRatingArrow.leftToRight(view: ratingInfoLabel, offset: Layout.RightArrow.left)
        commentImageView.leftToRight(view: rightRatingArrow, offset: Layout.CommentIcon.left)
        commentsCountLabel.leftToRight(view: commentImageView, offset: Layout.CommentLabel.left)
        commentsCountLabel.rightToLeft(view: publicationDateLabel, offset: Layout.CommentLabel.right, relation: .lessThanOrEqual)
        publicationDateLabel.rightToSuperView(offset: Layout.Date.right)
    }
}
