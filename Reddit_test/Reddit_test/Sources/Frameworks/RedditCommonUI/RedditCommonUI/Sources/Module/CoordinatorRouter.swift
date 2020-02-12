//
//  CoordinatorRouter.swift
//  Reddit_test
//
//  Created by Artem Belenkov on 12.02.2020.
//  Copyright © 2020 Artem Belenkov. All rights reserved.
//

import UIKit
import RedditCommon

open class CoordinatorRouter: NSObject, CoordinatorRouterProtocol {
    private var completions: [UIViewController: EmptyBlock] = [:]
    private var currentController: UIViewController?
    
    public let rootViewController: UIViewController
    
    public init(_ rootViewController: UIViewController = UIViewController()) {
        self.rootViewController = rootViewController
        super.init()
        self.rootViewController.navigationController?.delegate = self
    }
    
    open func showScreen(_ module: PresentableProtocol) {
        completions.forEach { $0.value.execute(()) }
        
        currentController?.view.removeFromSuperview()
        currentController?.removeFromParent()
        
        currentController = module.toPresent()
        rootViewController.addChildController(module.toPresent(), { view in
            view.fillSuperview()
        })
    }
    
    open func push(_ module: PresentableProtocol, animated: Bool, hideBottomBar: Bool, completion: EmptyBlock?) {
        let controller = module.toPresent()
        guard controller is UINavigationController == false else {
            assertionFailure("Deprecated push UINavigationController.")
            return
        }
        
        if let completion = completion {
            completions[controller] = completion
        }
        
        controller.hidesBottomBarWhenPushed = hideBottomBar
        guard let navController = rootViewController.navigationController else {
            (rootViewController.children.first as? UINavigationController)?.pushViewController(controller, animated: animated)
            return
        }
        navController.pushViewController(controller, animated: animated)
    }
    
    open func popModule(animated: Bool) {
        if let controller = rootViewController.navigationController?.popViewController(animated: animated) {
            runCompletion(for: controller)
        }
    }
    
    open func popToRootModule(animated: Bool) {
        if let controllers = rootViewController.navigationController?.popToRootViewController(animated: animated) {
            controllers.forEach { runCompletion(for: $0) }
        }
    }
    
    private func runCompletion(for controller: UIViewController) {
        guard let completion = completions[controller] else {
            return
        }
        completion.execute(())
        completions.removeValue(forKey: controller)
    }
}

// MARK: UINavigationController Delegate
extension CoordinatorRouter: UINavigationControllerDelegate {
    public func navigationController(_ navigationController: UINavigationController,
                                     didShow viewController: UIViewController,
                                     animated: Bool) {
        guard let poppedViewController = navigationController.transitionCoordinator?.viewController(forKey: .from),
            !navigationController.viewControllers.contains(poppedViewController) else {
                return
        }
        
        runCompletion(for: poppedViewController)
    }
}
