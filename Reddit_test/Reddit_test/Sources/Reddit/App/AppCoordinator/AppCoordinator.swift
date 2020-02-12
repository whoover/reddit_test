//
//  AppCoordinator.swift
//  Reddit_test
//
//  Created by Artem Belenkov on 12.02.2020.
//  Copyright © 2020 Artem Belenkov. All rights reserved.
//

import UIKit
import RedditCommonUI

protocol AppCoordinatorExitPoint: ModuleRoutingHandlingProtocol {
    func simpleModule()
}

protocol AppCoordinatorProtocol: CoordinatorProtocol {
    
}

final class AppCoordinator: BaseCoordinator, AppCoordinatorProtocol {
    typealias ServiceLocator = RootRouterLocator
    final class ServiceLocatorImpl: ServiceLocator {}
    
    private var instructor: LaunchInstructor {
        LaunchInstructor.configure()
    }
    
    init(serviceLocator: ServiceLocator = ServiceLocatorImpl()) {
        super.init(router: serviceLocator.rootRouter())
    }
    
    override func start(with option: DeepLinkOption?) {
        if let option = option {
            switch option {
            case .main:
//                startMainFlow()
                print("")
            case .photo(let url):
                break
            }
        } else {
            runLaunchInstructor()
        }
    }
    
    private func runLaunchInstructor() {
        switch instructor {
        case .main:
//            startMainFlow()
            print("")
        }
    }
}

// MARK: Main Flow
//extension AppCoordinator {
//    func startMainFlow() {
//        let coordinator = MainFlowCoordinatorAssembly().build(self, config, reachability)
//        coordinator.start()
//        addChild(coordinator)
//
//        self.router.showScreen(coordinator.toPresent())
//    }
//}
//
//extension AppCoordinator: MainFlowRoutingExitHandler {
//    func logout(_ coordinator: BaseFlowCoordinator) {
//        startAuthFlow()
//        removeChild(coordinator)
//    }
//}
