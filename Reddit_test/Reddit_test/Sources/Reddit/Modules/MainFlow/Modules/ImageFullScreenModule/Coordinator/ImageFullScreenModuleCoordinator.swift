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
    
    override func start() {
        let module = ImageFullScreenModuleAssembly().build(nil, self)
        let navController = UINavigationController(rootViewController: module.toPresent())
        router.showScreen(navController)
    }
}

extension ImageFullScreenModuleCoordinator: ImageFullScreenModuleRoutingHandlingProtocol {
    func performRouteForSomeAction() {
        
    }
}
