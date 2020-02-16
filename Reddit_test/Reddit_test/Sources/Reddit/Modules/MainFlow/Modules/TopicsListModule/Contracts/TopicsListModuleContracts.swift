//
//  TopicsListModuleContracts.swift
//  Reddit_test
//
//  Created by Artem Belenkov on 13/02/2020
//  Copyright © 2020 Artem Belenkov. All rights reserved.
//

import Foundation
import RedditCoreServices

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
    func loadMoreDataIfNeeded()
    func loadImage(_ imageURL: URL, _ completionBlock: BlockObject<LoadedImage?, Void>) -> CancellableProtocol?
    func wantsOpenImage(_ identifier: UUID)
}

// Interactor Input
protocol TopicsListModuleInteractorInput {
    func onStart(completionBlock: BlockObject<[RedditTopicCellModel], Void>)
    func loadTopics(progressBlock: BlockObject<TopicsScreenState, Void>)
    func reloadTopics(progressBlock: BlockObject<TopicsScreenState, Void>)
    func loadImage(_ imageURL: URL, _ completionBlock: BlockObject<LoadedImage?, Void>) -> CancellableProtocol?
}

// Router
protocol TopicsListModuleRouterInputProtocol: AlertRoutableProtocol {
    func routeForOpenImageAction(_ url: URL)
}

// Routing Handling
protocol TopicsListModuleRoutingHandlingProtocol: ModuleRoutingHandlingProtocol {
    func performRouteForOpenImageAction(_ url: URL)
}

// Coordinator Routing Handling
protocol TopicsListModuleCoordinatorExitRoutingProtocol: FlowExitPointProtocol {
    func performRouteForTapImageAction(_ coordinator: CoordinatorProtocol, _ url: URL)
}
