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
    func openImage(_ identifier: UUID)
}

final class RedditTopicCell: RedditTopicBaseCell {
    private let topicImageView = UIImageView()
    private let thumbnailImageActivityIndicator = UIActivityIndicatorView()
    private let fullScreenImageView = UIImageView()
    
    private weak var delegate: RedditTopicCellDelegate?
    private var loadTask: CancellableProtocol?
    private var identifier: UUID?
    private var hasFullScreen: Bool = false
    
    override func setupSubviews() {
        super.setupSubviews()
        contentView.addSubview(topicImageView)
        topicImageView.addSubview(thumbnailImageActivityIndicator)
        topicImageView.addSubview(fullScreenImageView)
        
        topicImageView.leftToSuperView(offset: Layout.Image.left)
        topicImageView.topToSuperView(offset: Layout.Image.top)
        topicImageView.width(Layout.Image.size)
        topicImageView.height(Layout.Image.size)
        topicImageView.bottomToSuperView(offset: Layout.Image.bottom, relation: .lessThanOrEqual)
        topicImageView.contentMode = .scaleAspectFit
        topicImageView.isUserInteractionEnabled = true
        thumbnailImageActivityIndicator.centerInSuperview()
        
        fullScreenImageView.leftToSuperView()
        fullScreenImageView.topToSuperView()
        fullScreenImageView.image = Image.Topic.fullScreenImage
        fullScreenImageView.width(20)
        fullScreenImageView.height(20)
        resetToDefault()
        setupGesture()
        
        topLabel.topToSuperView(offset: Layout.TopLabel.top)
        topLabel.leftToRight(view: topicImageView, offset: Layout.TopLabel.left)
        topLabel.rightToSuperView(offset: Layout.TopLabel.right)
        topLabel.bottomToTop(view: titleLabel, offset: Layout.TopLabel.bottom)

        titleLabel.leftToRight(view: topicImageView, offset: Layout.Title.left)
        titleLabel.rightToSuperView(offset: Layout.Title.right)
        titleLabel.bottomToTop(view: bottomLabel, offset: Layout.Title.bottom)
        
        bottomLabel.leftToRight(view: topicImageView, offset: Layout.Title.left)
        bottomLabel.rightToSuperView(offset: Layout.Title.right)
        bottomLabel.bottomToSuperView(offset: Layout.Bottom.bottom, relation: .lessThanOrEqual)
        
        separator.leftToSuperView()
        separator.rightToSuperView()
        separator.bottomToSuperView()
        separator.height(Layout.Separator.height)
        separator.backgroundColor = .lightGray
    }
    
    private func setupGesture() {
        let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapImage))
        topicImageView.addGestureRecognizer(tapGesture)
    }
    
    @objc private func didTapImage() {
        guard let identifier = identifier, hasFullScreen else {
            return
        }
        
        delegate?.openImage(identifier)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        loadTask?.cancel()
        resetToDefault()
    }

    override func configure(_ cellModel: CellModelProtocol, _ delegate: Any?) {
        super.configure(cellModel, delegate)
        self.delegate = delegate as? RedditTopicCellDelegate
        guard let cellModel = cellModel as? RedditTopicCellModel else {
            return
        }
        
        topLabel.text = "\(cellModel.author.text as? String ?? "")\n\(cellModel.time.text as? String ?? "")"
        self.identifier = cellModel.identifier
        hasFullScreen = cellModel.hasBigImage
        if let thumbnailURLString = cellModel.thumbnailURLString,
            let url = URL(string: thumbnailURLString) {
            loadTask = loadImage(url, cellModel.identifier)
        }
    }
}

extension RedditTopicCell: ImageLoadableProtocol {
    static let defaultImage: UIImage? = Image.Topic.defaultImage
    
    func loadImage(_ imageURL: URL, _ identifier: UUID) -> CancellableProtocol? {
        thumbnailImageActivityIndicator.startAnimating()
        let completionBlock = BlockObject<LoadedImage?, Void> { [weak self] image in
            guard let self = self else {
                return
            }
            
            self.thumbnailImageActivityIndicator.stopAnimating()
            self.topicImageView.image = image?.image ?? type(of: self).defaultImage
            self.fullScreenImageView.isHidden = !self.hasFullScreen
        }
        return delegate?.loadImage(imageURL, identifier, completionBlock)
    }
    
    func resetToDefault() {
        topicImageView.image = type(of: self).defaultImage
    }
}
