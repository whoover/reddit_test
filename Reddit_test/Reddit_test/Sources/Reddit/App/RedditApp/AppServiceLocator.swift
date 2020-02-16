//
//  AppServiceLocator.swift
//  Reddit_test
//
//  Created by Artem Belenkov on 12.02.2020.
//  Copyright © 2020 Artem Belenkov. All rights reserved.
//

import UIKit

protocol AppServiceLocator {
    func app() -> AppProtocol
}

extension AppServiceLocator {
    func app() -> AppProtocol {
        RedditApp()
    }
}

final class AppServiceLocatorImpl: AppServiceLocator {}
