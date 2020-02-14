//
//  ImageDownloadServiceLocator.swift
//  RedditCoreServices
//
//  Created by Artem Belenkov on 11/02/2020.
//  Copyright © 2020 Artem Belenkov. All rights reserved.
//

import RedditNetworking

public protocol ImageDownloadServiceLocatorProtocol {
    func imageDownloadService() -> ImageDownloadServiceProtocol
}

extension ImageDownloadServiceLocatorProtocol {
    public func imageDownloadService() -> ImageDownloadServiceProtocol {
        ImageDownloadService()
    }
}
