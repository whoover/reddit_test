//
//  ImageFullScreenModuleAssembly.swift
//  Reddit_test
//
//  Created by Artem Belenkov on 13/02/2020
//  Copyright © 2020 Artem Belenkov. All rights reserved.
//

import UIKit

typealias ImageFullScreenModule = Module<ImageFullScreenModuleInput, ImageFullScreenModuleOutput>

class ImageFullScreenModuleAssembly: AssemblyProtocol {
    func build(_ moduleOutput: ImageFullScreenModuleOutput?,
               _ routingHandler: ImageFullScreenModuleRoutingHandlingProtocol) -> ImageFullScreenModule {
        // View
        let view = ImageFullScreenModuleViewController()
        
        // Interactor
        let interactor = ImageFullScreenModuleInteractor()
        
        // Router
        let router = ImageFullScreenModuleRouter(viewController: view)
        
        // Presenter
        let presenter = ImageFullScreenModulePresenter(interactor: interactor, router: router, view: view, moduleOutput: moduleOutput)
        
        // Dependency Setup
        view.output = presenter
        interactor.output = presenter
        router.routingHandler = routingHandler
        
        return Module(view: view, input: presenter, output: moduleOutput)
    }
}
