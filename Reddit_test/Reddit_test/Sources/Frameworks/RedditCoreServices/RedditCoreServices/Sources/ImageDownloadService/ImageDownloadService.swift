//
//  ImageDownloadService.swift
//  RedditCoreServices
//
//  Created by Artem Belenkov on 11/02/2020.
//  Copyright © 2020 Artem Belenkov. All rights reserved.
//

import UIKit
import RedditCommon
import RedditNetworking

protocol ImageDownloadServiceProtocol {
    func downloadImage(with url: URL, completionBlock: BlockObject<UIImage?, Void>) -> CancellableProtocol?
}

class ImageDownloadService: ImageDownloadServiceProtocol {
    private let networkingManager: NetworkingManager
    private let imageCache: ImageCache
    
    init(networkingManager: NetworkingManager, imageCache: ImageCache) {
        self.networkingManager = networkingManager
        self.imageCache = imageCache
    }
    
    func downloadImage(with url: URL, completionBlock: BlockObject<UIImage?, Void>) -> CancellableProtocol? {
        nil
    }
}
