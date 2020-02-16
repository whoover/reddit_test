//
//  BaseCoordinator.swift
//  Reddit_test
//
//  Created by Artem Belenkov on 12.02.2020.
//  Copyright © 2020 Artem Belenkov. All rights reserved.
//

import UIKit

open class BaseCoordinator: CoordinatorProtocol {
    public let router: CoordinatorRouterProtocol
    public var childCoordinators: [CoordinatorProtocol] = []
    
    public init(router: CoordinatorRouterProtocol) {
        self.router = router
    }
    
    open func start(with option: DeepLinkOptionProtocol?) {
        
    }
    
    open func start() {
        start(with: nil)
    }
    
    open func addChild(_ coordinator: CoordinatorProtocol) {
        guard !childCoordinators.contains(where: { $0 === coordinator }) else {
            return
        }
        childCoordinators.append(coordinator)
    }
    
    open func removeChild(_ coordinator: CoordinatorProtocol?) {
        guard childCoordinators.isEmpty == false, let coordinator = coordinator else {
            return
        }
        
        // Clear child-coordinators recursively
        if let coordinator = coordinator as? BaseCoordinator, !coordinator.childCoordinators.isEmpty {
            coordinator.childCoordinators.filter({ $0 !== coordinator }).forEach({ coordinator.removeChild($0) })
        }
        
        for (index, element) in childCoordinators.enumerated() where element === coordinator {
            childCoordinators.remove(at: index)
            break
        }
    }
}
