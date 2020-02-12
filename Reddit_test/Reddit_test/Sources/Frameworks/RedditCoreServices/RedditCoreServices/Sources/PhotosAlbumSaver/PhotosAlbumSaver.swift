//
//  PhotosAlbumSaver.swift
//  RedditCoreServices
//
//  Created by Artem Belenkov on 12.02.2020.
//  Copyright © 2020 Artem Belenkov. All rights reserved.
//

import UIKit
import RedditCommon

public protocol PhotosAlbumSaverProtocol {
    func saveImageToCameraRoll(image: UIImage, completionBlock: BlockObject<Error?, Void>)
}

public class PhotosAlbumSaver: NSObject, PhotosAlbumSaverProtocol {
    private var completionBlock: BlockObject<Error?, Void>?

    public func saveImageToCameraRoll(image: UIImage,
                                      completionBlock: BlockObject<Error?, Void>) {
        self.completionBlock = completionBlock
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
    }

    @objc private func image(_ image: UIImage,
                             didFinishSavingWithError error: Error?,
                             contextInfo: UnsafeRawPointer) {
        completionBlock?.execute(error)
        completionBlock = nil
    }
}
