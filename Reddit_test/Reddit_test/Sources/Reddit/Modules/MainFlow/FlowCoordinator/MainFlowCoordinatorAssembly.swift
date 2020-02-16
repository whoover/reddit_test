//
//  MainFlowCoordinatorAssembly.swift
//  Reddit_test
//
//  Created by Artem Belenkov on 13/02/2020
//	Copyright © 2020 Artem Belenkov. All rights reserved.
//

import UIKit

final class MainFlowCoordinatorAssembly: AssemblyProtocol {
    func build(_ coordinatorRoutingHandler: MainFlowRoutingExitHandler) -> MainFlowCoordinatorProtocol {
        let router = CoordinatorRouter()
        let coordinator = MainFlowCoordinator(router: router)
        coordinator.exitRoutingDelegate = coordinatorRoutingHandler
        return coordinator
    }
}
