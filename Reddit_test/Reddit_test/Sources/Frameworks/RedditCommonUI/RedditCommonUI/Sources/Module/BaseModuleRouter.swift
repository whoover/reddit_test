//
//  BaseModuleRouter.swift
//  Reddit_test
//
//  Created by Artem Belenkov on 12.02.2020.
//  Copyright © 2020 Artem Belenkov. All rights reserved.
//

import UIKit

public protocol BaseModuleRoutable {
    var viewController: ViewControllerProtocol? { get }
}

open class BaseModuleRouter: BaseModuleRoutable {
    public weak var viewController: ViewControllerProtocol?
    
    public init(viewController: ViewControllerProtocol) {
        self.viewController = viewController
    }
}

extension BaseModuleRouter: PresentableProtocol {
    public func toPresent() -> UIViewController? { viewController }
}
