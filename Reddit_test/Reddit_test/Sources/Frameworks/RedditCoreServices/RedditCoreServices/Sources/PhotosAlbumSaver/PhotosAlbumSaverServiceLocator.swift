//
//  PhotosAlbumSaverServiceLocator.swift
//  RedditCoreServices
//
//  Created by Artem Belenkov on 12.02.2020.
//  Copyright © 2020 Artem Belenkov. All rights reserved.
//

import UIKit

public protocol PhotosAlbumSaverServiceLocator {
    func photosAlbumSaver() -> PhotosAlbumSaverProtocol
}

extension PhotosAlbumSaverServiceLocator {
    public func photosAlbumSaver() -> PhotosAlbumSaverProtocol {
        PhotosAlbumSaver()
    }
}
