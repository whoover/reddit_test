//
//  ImageFullScreenModulePresenter.swift
//  Reddit_test
//
//  Created by Artem Belenkov on 13/02/2020
//  Copyright © 2020 Artem Belenkov. All rights reserved.
//

import Foundation

class ImageFullScreenModulePresenter: BasePresenter
<ImageFullScreenModuleOutput,
ImageFullScreenModuleInteractorInput,
ImageFullScreenModuleRouterInputProtocol,
ImageFullScreenModuleViewInput> {
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
        
    }
    
    func didTapCloseModule() {
        router.closeModule()
    }
    
    func viewDidLoad() {
        view?.set(title: "ImageFullScreenModule")
    }
}

// MARK: Interactor Output
extension ImageFullScreenModulePresenter: ImageFullScreenModuleInteractorOutput {
    
}
