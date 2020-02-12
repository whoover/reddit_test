//
//  ImageDownloadServiceLocator.swift
//  RedditCoreServices
//
//  Created by Artem Belenkov on 11/02/2020.
//  Copyright © 2020 Artem Belenkov. All rights reserved.
//

import RedditNetworking

protocol ImageDownloadServiceLocatorProtocol {
    static func imageDownloadService() -> ImageDownloadServiceProtocol
}

extension ImageDownloadServiceLocatorProtocol {
    static func imageDownloadService() -> ImageDownloadServiceProtocol {
        ImageDownloadService()
    }
}
