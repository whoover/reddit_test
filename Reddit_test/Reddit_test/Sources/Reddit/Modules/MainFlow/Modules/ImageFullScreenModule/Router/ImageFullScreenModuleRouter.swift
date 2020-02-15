//
//  ImageFullScreenModuleRouter.swift
//  Reddit_test
//
//  Created by Artem Belenkov on 13/02/2020
//  Copyright © 2020 Artem Belenkov. All rights reserved.
//

import Foundation

class ImageFullScreenModuleRouter: BaseModuleRouter {
    weak var routingHandler: ImageFullScreenModuleRoutingHandlingProtocol?
}

extension ImageFullScreenModuleRouter: ImageFullScreenModuleRouterInputProtocol {
    func closeModule() {
        viewController?.dismiss(animated: true, completion: nil)
        routingHandler?.performRouteForCloseAction()
    }
}
