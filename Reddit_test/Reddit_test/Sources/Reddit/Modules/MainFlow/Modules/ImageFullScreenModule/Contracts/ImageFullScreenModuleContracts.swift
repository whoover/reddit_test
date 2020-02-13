//
//  ImageFullScreenModuleContracts.swift
//  Reddit_test
//
//  Created by Artem Belenkov on 13/02/2020
//  Copyright © 2020 Artem Belenkov. All rights reserved.
//

import Foundation

// Module Input
protocol ImageFullScreenModuleInput {
    
}

// Module Output
protocol ImageFullScreenModuleOutput {
    
}

// View Input
protocol ImageFullScreenModuleViewInput: class {
    func set(title: String)
}

// View Output
protocol ImageFullScreenModuleViewOutput: class {
    func viewDidLoad()
}

// Interactor Input
protocol ImageFullScreenModuleInteractorInput {
    
}

// Interactor Output
protocol ImageFullScreenModuleInteractorOutput: class {
    
}

// Router
protocol ImageFullScreenModuleRouterInputProtocol: AlertRoutableProtocol {
    
}

// Routing Handling
protocol ImageFullScreenModuleRoutingHandlingProtocol: ModuleRoutingHandlingProtocol {
    func performRouteForSomeAction()
}

// Coordinator Routing Handling
protocol ImageFullScreenModuleCoordinatorExitRoutingProtocol: FlowExitPointProtocol {
    func didCloseModule(_ coordinator: CoordinatorProtocol)
}
