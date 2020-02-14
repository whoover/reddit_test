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

public struct LoadedImage {
    public let image: UIImage?
    public let imageSource: ImageSource
    
    public init(image: UIImage?, imageSource: ImageSource) {
        self.image = image
        self.imageSource = imageSource
    }
}

public enum ImageSource {
    case cache
    case network
}

public protocol ImageDownloadServiceProtocol {
    func downloadImage(with url: URL, completionBlock: BlockObject<LoadedImage?, Void>) -> CancellableProtocol?
}

public final class ImageDownloadService: ImageDownloadServiceProtocol {
    typealias ServiceLocator = NetworkingManagerServiceLocator & ImageCacheServiceLocator
    public final class ServiceLocatorImpl: ServiceLocator {}
    
    private let networkingManager: NetworkingManagerProtocol
    private let imageCache: ImageCacheProtocol
    
    init(serviceLocator: ServiceLocator = ServiceLocatorImpl()) {
        self.networkingManager = serviceLocator.networkingManager(syncQueue: .main)
        self.imageCache = serviceLocator.imageCache()
    }
    
    public func downloadImage(with url: URL, completionBlock: BlockObject<LoadedImage?, Void>) -> CancellableProtocol? {
        let request = URLRequest(url: url)
        if let response = imageCache.cachedResponse(for: request) {
            let image = UIImage(data: response.data)
            completionBlock.execute(LoadedImage(image: image, imageSource: .cache))
            return nil
        }
        
        let successBlock = BlockObject<DataResponse, Void> { [weak self] dataResponse in
            self?.imageCache.storeCachedResponse(
                CachedURLResponse(response: dataResponse.httpResponse, data: dataResponse.data), for: request
            )
            let image = UIImage(data: dataResponse.data)
            completionBlock.execute(LoadedImage(image: image, imageSource: .network))
        }
        let errorBlock = BlockObject<Error, Void> { _ in
            completionBlock.execute(nil)
        }
        
        return networkingManager.sendGetRequest(request: SimpleRequest(url: url),
                                                successBlock: successBlock,
                                                errorBlock: errorBlock)
    }
}
