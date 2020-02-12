//
//  ImageCacheServiceLocator.swift
//  RedditCoreServices
//
//  Created by Artem Belenkov on 12.02.2020.
//  Copyright © 2020 Artem Belenkov. All rights reserved.
//

import UIKit

public protocol ImageCacheServiceLocator {
    func imageCache() -> ImageCacheProtocol
}

extension ImageCacheServiceLocator {
    public func imageCache() -> ImageCacheProtocol {
        let cacheSize = 128 * 1024 * 1024
        return URLCache(memoryCapacity: cacheSize,
                        diskCapacity: cacheSize,
                        diskPath: "com.reddit.imageCache")
    }
}
