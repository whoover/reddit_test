//
//  TopicsListModuleRouter.swift
//  Reddit_test
//
//  Created by Artem Belenkov on 13/02/2020
//  Copyright © 2020 Artem Belenkov. All rights reserved.
//

import Foundation

class TopicsListModuleRouter: BaseModuleRouter {
    weak var routingHandler: TopicsListModuleRoutingHandlingProtocol?
}

extension TopicsListModuleRouter: TopicsListModuleRouterInputProtocol {
    func routeForOpenImageAction(_ url: URL) {
        routingHandler?.performRouteForOpenImageAction(url)
    }
}
