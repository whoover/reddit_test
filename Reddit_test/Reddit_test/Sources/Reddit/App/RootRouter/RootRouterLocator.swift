//
//  RootRouterLocator.swift
//  Reddit_test
//
//  Created by Artem Belenkov on 12.02.2020.
//  Copyright © 2020 Artem Belenkov. All rights reserved.
//

import UIKit
import RedditCommonUI

protocol RootRouterLocator {
    func rootRouter() -> CoordinatorRouter
}

extension RootRouterLocator {
    func rootRouter() -> CoordinatorRouter {
        RootRouter()
    }
}
