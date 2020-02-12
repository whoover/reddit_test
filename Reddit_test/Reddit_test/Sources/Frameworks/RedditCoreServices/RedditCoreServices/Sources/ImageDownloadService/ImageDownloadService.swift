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

public final class ImageDownloadService: ImageDownloadServiceProtocol {
    typealias ServiceLocator = NetworkingManagerServiceLocator & ImageCacheServiceLocator
    public final class ServiceLocatorImpl: ServiceLocator {}
    
    private let networkingManager: NetworkingManagerProtocol
    private let imageCache: ImageCacheProtocol
    
    init(serviceLocator: ServiceLocator = ServiceLocatorImpl()) {
        self.networkingManager = serviceLocator.networkingManager()
        self.imageCache = serviceLocator.imageCache()
    }
    
    func downloadImage(with url: URL, completionBlock: BlockObject<UIImage?, Void>) -> CancellableProtocol? {
        let request = URLRequest(url: url)
        if let response = imageCache.cachedResponse(for: request) {
            let image = UIImage(data: response.data)
            completionBlock.execute(image)
            return nil
        }
        
        let successBlock = BlockObject<DataResponse, Void> { [weak self] dataResponse in
            self?.imageCache.storeCachedResponse(
                CachedURLResponse(response: dataResponse.httpResponse, data: dataResponse.data), for: request
            )
        }
        let errorBlock = BlockObject<Error, Void> { _ in
            completionBlock.execute(nil)
        }
        
        return networkingManager.sendGetRequest(request: SimpleRequest(url: url),
                                                successBlock: successBlock,
                                                errorBlock: errorBlock)
    }
}
