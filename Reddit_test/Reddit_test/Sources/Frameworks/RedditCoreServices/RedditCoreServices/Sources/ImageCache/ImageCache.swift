//
//  ImageCache.swift
//  RedditCoreServices
//
//  Created by Artem Belenkov on 11/02/2020.
//  Copyright © 2020 Artem Belenkov. All rights reserved.
//

import Foundation

public protocol ImageCacheProtocol {
    func cachedResponse(for request: URLRequest) -> CachedURLResponse?
    func storeCachedResponse(_ cachedResponse: CachedURLResponse, for request: URLRequest)
}

extension URLCache: ImageCacheProtocol {}
