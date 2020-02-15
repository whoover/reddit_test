//
//  ImageFullScreenModulePresenter.swift
//  Reddit_test
//
//  Created by Artem Belenkov on 13/02/2020
//  Copyright © 2020 Artem Belenkov. All rights reserved.
//

import Foundation
import RedditCoreServices

class ImageFullScreenModulePresenter: BasePresenter
<ImageFullScreenModuleOutput,
ImageFullScreenModuleInteractorInput,
ImageFullScreenModuleRouterInputProtocol,
ImageFullScreenModuleViewInput> {
    var restorationImageURL: URL?
}

// MARK: Private
extension ImageFullScreenModulePresenter {
    
}

// MARK: Module Input
extension ImageFullScreenModulePresenter: ImageFullScreenModuleInput {
    
}

// MARK: View Output
extension ImageFullScreenModulePresenter: ImageFullScreenModuleViewOutput {
    func didTapSaveImage() {
        let successBlock = EmptyBlock { [weak self] in
            self?.view?.didSaveImage()
        }
        let errorBlock = BlockObject<Error, Void> { [weak self] error in
            self?.view?.errorOnSavingImage()
            self?.router.showAlert(title: "Error on saving", message: error.localizedDescription)
        }
        interactor.saveImageToCameraRoll(successBlock: successBlock, errorBlock: errorBlock)
    }
    
    func didTapCloseModule() {
        interactor.cancelImageDownloadingIfNeeded()
        router.closeModule()
    }
    
    func viewDidLoad() {
        guard let imageURL = restorationImageURL else {
            return
        }
        
        let completionBlock = BlockObject<LoadedImage?, Void> { [weak self] image in
            self?.view?.setupImage(image?.image)
        }
        interactor.downloadImage(imageURL, completionBlock)
    }
}
