//
//  ImageDownloadServiceLocator.swift
//  RedditCoreServices
//
//  Created by Artem Belenkov on 11/02/2020.
//  Copyright © 2020 Artem Belenkov. All rights reserved.
//

import RedditNetworking

protocol ImageDownloadServiceLocatorProtocol {
    static func imageDownloadService(networkingManager: NetworkingManager) -> ImageDownloadServiceProtocol
}

extension ImageDownloadServiceLocatorProtocol {
    static func imageDownloadService(networkingManager: NetworkingManager) -> ImageDownloadServiceProtocol {
        let cache = URLCache(
            memoryCapacity: 128 * 1024 * 1024,
            diskCapacity: 128 * 1024 * 1024,
            diskPath: "com.reddit.imageCache"
        )
        
        return ImageDownloadService(networkingManager: networkingManager, imageCache: cache)
    }
}
