//
//  BaseCompositeModuleRouter.swift
//  Reddit_test
//
//  Created by Artem Belenkov on 12.02.2020.
//  Copyright © 2020 Artem Belenkov. All rights reserved.
//

import UIKit

class BaseCompositeModuleRouter<ContainersHolder: ContainersHolderProtocol>: BaseModuleRoutable {
    let viewController: ViewControllerProtocol
    let containersHolder: ContainersHolder
        
    init(viewController: ViewControllerProtocol, containersHolder: ContainersHolder) {
        self.viewController = viewController
        self.containersHolder = containersHolder
    }
    
    func showSubmodule(_ presentable: PresentableProtocol, _ container: UIView) {
        let viewControllerToPresent = presentable.toPresent()
        viewControllerToPresent.willMove(toParent: viewController)
        viewController.addChild(viewControllerToPresent)
        container.addSubview(viewControllerToPresent.view)
        viewControllerToPresent.view.fillSuperview()
        viewControllerToPresent.didMove(toParent: viewController)
    }
}

extension BaseCompositeModuleRouter: PresentableProtocol {
    func toPresent() -> UIViewController { viewController }
}
