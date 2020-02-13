//
//  TopicsListModuleCoordinatorAssembly.swift
//  Reddit_test
//
//  Created by Artem Belenkov on 13/02/2020
//	Copyright © 2020 Artem Belenkov. All rights reserved.
//

import UIKit

class TopicsListModuleCoordinatorAssembly: AssemblyProtocol {
    func build(router: CoordinatorRouterProtocol,
               routingHandler: TopicsListModuleCoordinatorExitRoutingProtocol) -> CoordinatorProtocol {
        let coordinator = TopicsListModuleCoordinator(router: router)
        coordinator.exitRoutingDelegate = routingHandler
        return coordinator
    }
}
