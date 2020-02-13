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
    
    func showLoadingIndicator()
    func reloadData()
    func finishedLoading()
}

// View Output
protocol TopicsListModuleViewOutput: class {
    var dataSource: RedditTopicDataSource { get }
    
    func viewDidLoad()
    func reloadTopics()
    func loadDataFromStorage()
}

// Interactor Input
protocol TopicsListModuleInteractorInput {
    func onStart(completionBlock: BlockObject<[RedditTopicModel], Void>)
    func loadTopics(progressBlock: BlockObject<TopicsScreenState, Void>)
    func reloadTopics(progressBlock: BlockObject<TopicsScreenState, Void>)
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
