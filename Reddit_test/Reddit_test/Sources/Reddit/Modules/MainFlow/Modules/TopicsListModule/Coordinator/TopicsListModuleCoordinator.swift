//
//  TopicsListModuleCoordinator.swift
//  Reddit_test
//
//  Created by Artem Belenkov on 13/02/2020
//	Copyright © 2020 Artem Belenkov. All rights reserved.
//

protocol TopicsListModuleCoordinatorProtocol: CoordinatorProtocol {
    
}

class TopicsListModuleCoordinator: BaseCoordinator, TopicsListModuleCoordinatorProtocol {
    weak var exitRoutingDelegate: TopicsListModuleCoordinatorExitRoutingProtocol?
    
    override func start() {
        let module = TopicsListModuleAssembly().build(nil, self)
        let navController = UINavigationController(rootViewController: module.toPresent())
        router.showScreen(navController)
    }
}

extension TopicsListModuleCoordinator: TopicsListModuleRoutingHandlingProtocol {
    func performRouteForSomeAction() {
        
    }
}