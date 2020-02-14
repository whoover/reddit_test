//
//  RedditTopicCell.swift
//  Reddit_test
//
//  Created by Artem Belenkov on 12.02.2020.
//  Copyright © 2020 Artem Belenkov. All rights reserved.
//

import UIKit
import RedditCommonUI
import RedditCoreServices

protocol RedditTopicCellDelegate: class {
    func loadImage(_ imageURL: URL, _ identifier: UUID, _ completionBlock: BlockObject<LoadedImage?, Void>) -> CancellableProtocol?
}

class RedditTopicCell: UITableViewCell, ConfigurableCellProtocol {
    private let author = UILabel()
    private let titleLabel = UILabel()
    private let topicImageView = UIImageView()
    private let bottomView = CellBottomView()
    private let separator = UIView()
    private let thumbnailImageActivityIndicator = UIActivityIndicatorView()
    
    private weak var delegate: RedditTopicCellDelegate?
    private var loadTask: CancellableProtocol?
    
    private struct Layout {
        struct Author {
            static let top: CGFloat = 4
            static let left: CGFloat = 4
            static let bottom: CGFloat = -4
        }
        struct Title {
            static let top: CGFloat = 4
            static let left: CGFloat = 4
            static let right: CGFloat = -4
            static let bottom: CGFloat = -4
        }
        struct Image {
            static let left: CGFloat = 0
            static let right: CGFloat = 0
            static let bottom: CGFloat = -4
        }
        struct Bottom {
            static let height: CGFloat = 28
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
    
    private func setupSubviews() {
        contentView.addSubview(author)
        contentView.addSubview(titleLabel)
        contentView.addSubview(topicImageView)
        topicImageView.addSubview(thumbnailImageActivityIndicator)
        contentView.addSubview(bottomView)
        addSubview(separator)
        
        author.topToSuperView(offset: Layout.Author.top)
        author.leftToSuperView(offset: Layout.Author.left)
        author.bottomToTop(view: titleLabel, offset: Layout.Author.bottom)
        
        titleLabel.leftToSuperView(offset: Layout.Title.top)
        titleLabel.rightToSuperView(offset: Layout.Title.right)
        titleLabel.bottomToTop(view: topicImageView, offset: Layout.Title.bottom)
        
        topicImageView.leftToSuperView(offset: Layout.Image.left)
        topicImageView.rightToSuperView(offset: Layout.Image.right)
        topicImageView.bottomToTop(view: bottomView, offset: Layout.Image.bottom)
        thumbnailImageActivityIndicator.centerInSuperview()
        resetToDefault()
        
        bottomView.leftToSuperView()
        bottomView.rightToSuperView()
        bottomView.bottomToSuperView()
        bottomView.height(Layout.Bottom.height)
        
        separator.leftToSuperView()
        separator.rightToSuperView()
        separator.bottomToSuperView()
        separator.height(1.0)
        separator.backgroundColor = .lightGray
        
        setupLabel()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        loadTask?.cancel()
        resetToDefault()
    }
    
    private func setupLabel() {
        titleLabel.numberOfLines = 0
    }

    func configure(_ cellModel: CellModelProtocol, _ delegate: Any?) {
        self.delegate = delegate as? RedditTopicCellDelegate
        guard let cellModel = cellModel as? RedditTopicCellModel else {
            return
        }
        
        author.text = cellModel.model.author
        titleLabel.text = cellModel.model.title
        bottomView.commentsCountLabel.text = "\(cellModel.model.commentsNumber)"
        bottomView.ratingInfoLabel.text = "\(cellModel.model.score)"
        bottomView.publicationDateLabel.text = "\(cellModel.model.created)"
        
        if let url = URL(string: cellModel.model.thumbnailURL) {
            loadTask = loadImage(url, cellModel.identifier)
        }
    }
}

extension RedditTopicCell: ImageLoadableProtocol {
    static let defaultImage: UIImage? = UIImage(named: "image_stub")
    
    func loadImage(_ imageURL: URL, _ identifier: UUID) -> CancellableProtocol? {
        thumbnailImageActivityIndicator.startAnimating()
        let completionBlock = BlockObject<LoadedImage?, Void> { [weak self] image in
            guard let self = self else {
                return
            }
            
            self.thumbnailImageActivityIndicator.stopAnimating()
            self.topicImageView.image = image?.image ?? type(of: self).defaultImage
        }
        return delegate?.loadImage(imageURL, identifier, completionBlock)
    }
    
    func resetToDefault() {
        topicImageView.image = type(of: self).defaultImage
    }
}
