//
//  MainFlowCoordinator.swift
//  Reddit_test
//
//  Created by Artem Belenkov on 13/02/2020
//	Copyright © 2020 Artem Belenkov. All rights reserved.
//

import Foundation

protocol MainFlowCoordinatorProtocol: BaseFlowCoordinator {
    func topicsController() -> UIViewController?
    func imageController(_ url: URL?) -> UIViewController?
}

final class MainFlowCoordinator: BaseFlowCoordinator, MainFlowCoordinatorProtocol {
    weak var exitRoutingDelegate: MainFlowRoutingExitHandler?
    
    override func start(with option: DeepLinkOptionProtocol?) {
        super.start(with: option)
        startTopicsListModule()
    }
        
    private func startTopicsListModule() {
        topicsController()
    }
    
    private func startImageFullScreenModule(_ url: URL) {
        imageController(url)
    }
    
    @discardableResult
    func topicsController() -> UIViewController? {
        let topicsListCoordinator = TopicsListModuleCoordinatorAssembly().build(router: router, routingHandler: self)
        topicsListCoordinator.start()
        addChild(topicsListCoordinator)
        return topicsListCoordinator.toPresent()
    }
    
    @discardableResult
    func imageController(_ url: URL?) -> UIViewController? {
        let imageFullScreenModule = ImageFullScreenModuleCoordinatorAssembly().build(router: router, routingHandler: self, url: url)
        imageFullScreenModule.start()
        addChild(imageFullScreenModule)
        return imageFullScreenModule.toPresent()
    }
}

extension MainFlowCoordinator: TopicsListModuleCoordinatorExitRoutingProtocol {
    func performRouteForTapImageAction(_ coordinator: CoordinatorProtocol, _ url: URL) {
        startImageFullScreenModule(url)
    }
}

extension MainFlowCoordinator: ImageFullScreenModuleCoordinatorExitRoutingProtocol {
    func didCloseModule(_ coordinator: CoordinatorProtocol) {
        removeChild(coordinator)
    }
}
