//
//  ImageFullScreenModuleCoordinator.swift
//  Reddit_test
//
//  Created by Artem Belenkov on 13/02/2020
//	Copyright © 2020 Artem Belenkov. All rights reserved.
//

protocol ImageFullScreenModuleCoordinatorProtocol: CoordinatorProtocol {
    
}

class ImageFullScreenModuleCoordinator: BaseCoordinator, ImageFullScreenModuleCoordinatorProtocol {
    weak var exitRoutingDelegate: ImageFullScreenModuleCoordinatorExitRoutingProtocol?
    private let url: URL?
    
    required init(router: CoordinatorRouterProtocol, url: URL?) {
        self.url = url
        super.init(router: router)
    }
    
    override func start() {
        var module = ImageFullScreenModuleAssembly().build(nil, self)
        module.input.restorationImageURL = url
        router.present(module)
    }
}

extension ImageFullScreenModuleCoordinator: ImageFullScreenModuleRoutingHandlingProtocol {
    func performRouteForCloseAction() {
        exitRoutingDelegate?.didCloseModule(self)
    }
}
