//
//  CellViewModelAppapterService.swift
//  Reddit_test
//
//  Created by Artem Belenkov on 15.02.2020.
//  Copyright © 2020 Artem Belenkov. All rights reserved.
//

import UIKit

protocol CellViewModelAddapterServiceProtocol {
    func convert(_ models: [RedditTopicModel]) -> [RedditTopicCellModel]
}

final class CellViewModelAddapterService: CellViewModelAddapterServiceProtocol {
    typealias ServiceLocator = ThemeServiceLocator
    final class ServiceLocatorImpl: ServiceLocator {}
    
    private let themeManager: ThemeManagerProtocol
    
    init(serviceLocator: ServiceLocator = ServiceLocatorImpl()) {
        themeManager = serviceLocator.themeService()
    }
    
    func convert(_ models: [RedditTopicModel]) -> [RedditTopicCellModel] {
        models.map { convert($0) }
    }
    
    private func convert(_ model: RedditTopicModel) -> RedditTopicCellModel {
        let title = Label(settings: themeManager.topic.text, text: model.title)
        let topLabelText = Label(settings: themeManager.topic.topLabelText, text: "Posted by \(model.author) \(Calendar.current.timeAgo(since: Date(timeIntervalSince1970: model.created)))")
            
        let thumbnailURLString = model.thumbnailURL.contains("http") ? model.thumbnailURL : nil
        let bottomLabelText = Label(settings: themeManager.topic.bottomLabelText, text: CellViewModelAddapterService.bottomLabelString(model.commentsNumber, model.score, themeManager.topic.bottomLabelText))
        
        return RedditTopicCellModel(topLabelText: topLabelText, title: title, bottomLabelText: bottomLabelText, thumbnailURLString: thumbnailURLString, separatorColor: themeManager.topic.separatorColor, fullScreenImageURLString: model.previewURL)
    }
    
    private static func bottomLabelString(_ comments: Int, _ rating: Int, _ textSettings: TextSetting) -> NSAttributedString {
        guard let color = textSettings.color else {
            return NSAttributedString()
        }
        let mutableString = NSMutableAttributedString()
        if let arrowImage = UIImage(named: "arrows")?.withTintColor(color) {
            let arrows = NSAttributedString(attachment: NSTextAttachment(image: arrowImage))
            mutableString.append(arrows)
            mutableString.append(NSAttributedString(string: comments.formatUsingAbbrevation().lowercased()))
            mutableString.append(NSAttributedString(string: "   "))
        }
        if let commentImage = UIImage(named: "comments")?.withTintColor(color) {
            let comments = NSAttributedString(attachment: NSTextAttachment(image: commentImage))
            mutableString.append(comments)
            mutableString.append(NSAttributedString(string: rating.formatUsingAbbrevation().lowercased()))
        }
        mutableString.addAttribute(.foregroundColor, value: color, range: mutableString.string.nsRange)
        return NSAttributedString(attributedString: mutableString)
    }
}
