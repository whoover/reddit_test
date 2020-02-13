//
//  TopicsListModuleContracts.swift
//  Reddit_test
//
//  Created by Artem Belenkov on 13/02/2020
//  Copyright © 2020 Artem Belenkov. All rights reserved.
//

import Foundation

// Module Input
protocol TopicsListModuleInput {
    
}

// Module Output
protocol TopicsListModuleOutput {
    
}

// View Input
protocol TopicsListModuleViewInput: class {
    func set(title: String)
}

// View Output
protocol TopicsListModuleViewOutput: class {
    func viewDidLoad()
}

// Interactor Input
protocol TopicsListModuleInteractorInput {
    
}

// Interactor Output
protocol TopicsListModuleInteractorOutput: class {
    
}

// Router
protocol TopicsListModuleRouterInputProtocol: AlertRoutableProtocol {
    
}

// Routing Handling
protocol TopicsListModuleRoutingHandlingProtocol: ModuleRoutingHandlingProtocol {
    func performRouteForSomeAction()
}

// Coordinator Routing Handling
protocol TopicsListModuleCoordinatorExitRoutingProtocol: FlowExitPointProtocol {
    func performRouteForTapImageAction(_ coordinator: CoordinatorProtocol, _ model: RedditTopicModel)
}
