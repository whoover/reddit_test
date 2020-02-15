//
//  AppCoordinator.swift
//  Reddit_test
//
//  Created by Artem Belenkov on 12.02.2020.
//  Copyright © 2020 Artem Belenkov. All rights reserved.
//

import UIKit
import RedditCommonUI

protocol AppCoordinatorExitPoint: ModuleRoutingHandlingProtocol { }
protocol AppCoordinatorProtocol: CoordinatorProtocol {
    func rootController() -> UIViewController?
    func photoController() -> UIViewController?
    func topicsController() -> UIViewController?
}

final class AppCoordinator: BaseCoordinator, AppCoordinatorProtocol {
    typealias ServiceLocator = RootRouterLocator
    final class ServiceLocatorImpl: ServiceLocator {}
    private lazy var coordinator = MainFlowCoordinatorAssembly().build(self)
    
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
                startMainFlow()
            case .photo:
                break
            }
        } else {
            runLaunchInstructor()
        }
    }
    
    private func runLaunchInstructor() {
        switch instructor {
        case .main:
            startMainFlow()
        }
    }
}

// MARK: Main Flow
extension AppCoordinator {
    func startMainFlow() {
        coordinator.start()
        addChild(coordinator)

        if let toPresent = coordinator.toPresent() {
            self.router.showScreen(toPresent)
        }
    }
}

extension AppCoordinator: MainFlowRoutingExitHandler {
    func rootController() -> UIViewController? {
        router.rootViewController
    }
    
    func topicsController() -> UIViewController? {
        coordinator.topicsController()
    }
    
    func photoController() -> UIViewController? {
        coordinator.imageController(nil)
    }
}
