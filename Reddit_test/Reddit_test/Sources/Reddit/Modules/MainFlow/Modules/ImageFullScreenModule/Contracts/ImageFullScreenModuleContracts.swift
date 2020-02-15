//
//  ImageFullScreenModuleContracts.swift
//  Reddit_test
//
//  Created by Artem Belenkov on 13/02/2020
//  Copyright © 2020 Artem Belenkov. All rights reserved.
//

import Foundation
import RedditCoreServices

// Module Input
protocol ImageFullScreenModuleInput {
    var restorationImageURL: URL? { get set }
}

// Module Output
protocol ImageFullScreenModuleOutput {
    
}

// View Input
protocol ImageFullScreenModuleViewInput: class {
    func setupImage(_ image: UIImage?)
    func didSaveImage()
    func errorOnSavingImage()
}

// View Output
protocol ImageFullScreenModuleViewOutput: class {
    var restorationImageURL: URL? { get set }
    
    func viewDidLoad()
    
    func didTapSaveImage()
    func didTapCloseModule()
}

// Interactor Input
protocol ImageFullScreenModuleInteractorInput {
    func downloadImage(_ url: URL, _ completionBlock: BlockObject<LoadedImage?, Void>)
    func saveImageToCameraRoll(successBlock: EmptyBlock, errorBlock: BlockObject<Error, Void>)
    func cancelImageDownloadingIfNeeded()
}

// Router
protocol ImageFullScreenModuleRouterInputProtocol: AlertRoutableProtocol {
    func closeModule()
}

// Routing Handling
protocol ImageFullScreenModuleRoutingHandlingProtocol: ModuleRoutingHandlingProtocol {
    func performRouteForCloseAction()
}

// Coordinator Routing Handling
protocol ImageFullScreenModuleCoordinatorExitRoutingProtocol: FlowExitPointProtocol {
    func didCloseModule(_ coordinator: CoordinatorProtocol)
}
