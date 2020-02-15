//
//  ImageFullScreenModuleAssembly.swift
//  Reddit_test
//
//  Created by Artem Belenkov on 13/02/2020
//  Copyright © 2020 Artem Belenkov. All rights reserved.
//

import UIKit

typealias ImageFullScreenModule = Module<ImageFullScreenModuleInput, ImageFullScreenModuleOutput>

class ImageFullScreenModuleAssembly: AssemblyProtocol, UIViewControllerRestoration {
    func build(_ moduleOutput: ImageFullScreenModuleOutput?,
               _ routingHandler: ImageFullScreenModuleRoutingHandlingProtocol?) -> ImageFullScreenModule {
        // View
        let view = ImageFullScreenModuleViewController.controllerFromStoryboard(StoryBoard.imageFullScreen.rawValue)
        view.restorationClass = type(of: self)
        // Interactor
        let interactor = ImageFullScreenModuleInteractor()
        
        // Router
        let router = ImageFullScreenModuleRouter(viewController: view)
        
        // Presenter
        let presenter = ImageFullScreenModulePresenter(interactor: interactor, router: router, view: view, moduleOutput: moduleOutput)
        
        // Dependency Setup
        view.output = presenter
        router.routingHandler = routingHandler
        
        return Module(view: view, input: presenter, output: moduleOutput)
    }
    
    static func viewController(withRestorationIdentifierPath identifierComponents: [String], coder: NSCoder) -> UIViewController? {
        var module = ImageFullScreenModuleAssembly().build(nil, nil)
        if let url = coder.decodeObject(forKey: ImageFullScreenModuleViewController.imageUrlRestorableKey) as? String {
            module.input.restorationImageURL = URL(string: url)
        }
        return module.view
    }
}
