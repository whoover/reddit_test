//
//  CoordinatorProtocol.swift
//  Reddit_test
//
//  Created by Artem Belenkov on 12.02.2020.
//  Copyright © 2020 Artem Belenkov. All rights reserved.
//

import UIKit

public protocol CoordinatorProtocol: AnyObject, PresentableProtocol {
    var router: CoordinatorRouterProtocol { get }
    
    func start()
    func start(with option: DeepLinkOptionProtocol?)
}

extension CoordinatorProtocol {
    public func toPresent() -> UIViewController? { router.toPresent() }
}

public protocol ModuleRoutingHandlingProtocol: class { }
public protocol FlowExitPointProtocol: class { }
