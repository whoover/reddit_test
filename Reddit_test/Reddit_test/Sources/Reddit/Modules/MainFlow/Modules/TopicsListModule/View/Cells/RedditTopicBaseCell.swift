//
//  RedditTopicBaseCell.swift
//  Reddit_test
//
//  Created by Artem Belenkov on 14/02/2020.
//  Copyright © 2020 Artem Belenkov. All rights reserved.
//

import UIKit
import RedditCommonUI
import RedditCoreServices

class RedditTopicBaseCell: UITableViewCell, ConfigurableCellProtocol {
    let author = UILabel()
    let titleLabel = UILabel()
    let bottomView = CellBottomView()
    let separator = UIView()
    
    struct Layout {
        struct Author {
            static let top: CGFloat = 4
            static let left: CGFloat = 8
            static let right: CGFloat = -4
            static let bottom: CGFloat = -8
        }
        struct Title {
            static let top: CGFloat = 4
            static let left: CGFloat = 8
            static let right: CGFloat = -4
            static let bottom: CGFloat = -4
        }
        struct Image {
            static let left: CGFloat = 4
            static let top: CGFloat = 4
            static let bottom: CGFloat = -4
            static let size: CGFloat = 140
        }
        struct Bottom {
            static let height: CGFloat = 28
            static let bottom: CGFloat = -8
        }
        struct Separator {
            static let height: CGFloat = 1
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupSubviews()
    }
    
    func setupSubviews() {
        contentView.addSubview(author)
        contentView.addSubview(titleLabel)
        contentView.addSubview(bottomView)
        contentView.addSubview(separator)
        setupLabel()
    }
    
    private func setupLabel() {
        titleLabel.numberOfLines = 0
    }

    func configure(_ cellModel: CellModelProtocol, _ delegate: Any?) {
        guard let cellModel = cellModel as? RedditTopicCellModel else {
            return
        }
        
        author.text = "posted \(Calendar.current.timeAgo(since: Date(timeIntervalSince1970: cellModel.model.created))) by \(cellModel.model.author)"
        
        titleLabel.text = cellModel.model.title
        bottomView.commentsCountLabel.text = cellModel.model.commentsNumber.formatUsingAbbrevation().lowercased()
        bottomView.ratingInfoLabel.text = cellModel.model.score.formatUsingAbbrevation().lowercased()
    }
}
