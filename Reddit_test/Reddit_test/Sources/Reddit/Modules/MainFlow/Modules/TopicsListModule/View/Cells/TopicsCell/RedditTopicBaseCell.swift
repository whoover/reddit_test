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
    let topLabel = UILabel()
    let titleLabel = UILabel()
    let bottomLabel = UILabel()
    let separator = UIView()
    
    struct Layout {
        struct TopLabel {
            static let top: CGFloat = Offset.small.rawValue
            static let left: CGFloat = Offset.normal.rawValue
            static let right: CGFloat = -Offset.small.rawValue
            static let bottom: CGFloat = -Offset.normal.rawValue
        }
        struct Title {
            static let top: CGFloat = Offset.small.rawValue
            static let left: CGFloat = Offset.normal.rawValue
            static let right: CGFloat = -Offset.small.rawValue
            static let bottom: CGFloat = -Offset.big.rawValue
        }
        struct Image {
            static let left: CGFloat = Offset.small.rawValue
            static let top: CGFloat = Offset.small.rawValue
            static let bottom: CGFloat = -Offset.big.rawValue
            static let size: CGFloat = 140
        }
        struct Bottom {
            static let bottom: CGFloat = -Offset.big.rawValue
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
        selectionStyle = .none
        contentView.addSubview(topLabel)
        contentView.addSubview(titleLabel)
        contentView.addSubview(bottomLabel)
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
        
        topLabel.text = cellModel.topLabelText.text as? String
        topLabel.font = cellModel.topLabelText.settings.font
        topLabel.textColor = cellModel.topLabelText.settings.color
        titleLabel.text = cellModel.title.text as? String
        titleLabel.font = cellModel.title.settings.font
        titleLabel.textColor = cellModel.title.settings.color
        bottomLabel.attributedText = cellModel.bottomLabelText.text as? NSAttributedString
    }
}
