//
//  ImageFullScreenModuleInteractor.swift
//  Reddit_test
//
//  Created by Artem Belenkov on 13/02/2020
//  Copyright © 2020 Artem Belenkov. All rights reserved.
//

import Foundation
import RedditCoreServices

enum ImageSavingError: Error {
    case noImage
}

final class ImageFullScreenModuleInteractor {
    typealias ServiceLocator = ImageDownloadServiceLocatorProtocol & PhotosAlbumSaverServiceLocator
    final class ServiceLocatorImpl: ServiceLocator {}
    
    private let imageDownloader: ImageDownloadServiceProtocol
    private let photosAlbumSaver: PhotosAlbumSaverProtocol
    private var downloadedImage: UIImage?
    private var downloadingTask: CancellableProtocol?
    
    init(serviceLocator: ServiceLocator = ServiceLocatorImpl()) {
        imageDownloader = serviceLocator.imageDownloadService()
        photosAlbumSaver = serviceLocator.photosAlbumSaver()
    }
}

// MARK: Private
extension ImageFullScreenModuleInteractor: ImageFullScreenModuleInteractorInput {
    func downloadImage(_ url: URL, _ completionBlock: BlockObject<LoadedImage?, Void>) {
        let completionBlock = BlockObject<LoadedImage?, Void> { [weak self] image in
            self?.downloadingTask = nil
            self?.downloadedImage = image?.image
            completionBlock.execute(image)
        }
        downloadingTask = imageDownloader.downloadImage(with: url, completionBlock: completionBlock)
    }
    
    func saveImageToCameraRoll(successBlock: EmptyBlock, errorBlock: BlockObject<Error, Void>) {
        guard let downloadedImage = downloadedImage else {
            errorBlock.execute(ImageSavingError.noImage)
            return
        }
        
        let completionBlock = BlockObject<Error?, Void> { error in
            guard let error = error else {
                successBlock.execute(())
                return
            }
            errorBlock.execute(error)
        }
        photosAlbumSaver.saveImageToCameraRoll(image: downloadedImage, completionBlock: completionBlock)
    }
    
    func cancelImageDownloadingIfNeeded() {
        downloadingTask?.cancel()
    }
}
