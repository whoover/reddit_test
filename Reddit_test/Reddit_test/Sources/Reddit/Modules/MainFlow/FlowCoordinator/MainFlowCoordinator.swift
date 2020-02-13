//
//  MainFlowCoordinator.swift
//  Reddit_test
//
//  Created by Artem Belenkov on 13/02/2020
//	Copyright © 2020 Artem Belenkov. All rights reserved.
//

import Foundation

class MainFlowCoordinator: BaseFlowCoordinator {
    weak var exitRoutingDelegate: MainFlowRoutingExitHandler?
    
    override func start(with option: DeepLinkOption?) {
        super.start(with: option)
        startTopicsListModule()
    }
        
    private func startTopicsListModule() {
        let topicsListCoordinator = TopicsListModuleCoordinatorAssembly().build(router: router, routingHandler: self)
        topicsListCoordinator.start()
        addChild(topicsListCoordinator)
    }
    
    private func startImageFullScreenModule() {
        let imageFullScreenModule = ImageFullScreenModuleCoordinatorAssembly().build(router: router, routingHandler: self)
        imageFullScreenModule.start()
        addChild(imageFullScreenModule)
    }
}

extension MainFlowCoordinator: TopicsListModuleCoordinatorExitRoutingProtocol {
    func performRouteForTapImageAction(_ coordinator: CoordinatorProtocol, _ model: RedditTopicModel) {
        startImageFullScreenModule()
    }
}

extension MainFlowCoordinator: ImageFullScreenModuleCoordinatorExitRoutingProtocol {
    func didCloseModule(_ coordinator: CoordinatorProtocol) {
        removeChild(coordinator)
    }
}
