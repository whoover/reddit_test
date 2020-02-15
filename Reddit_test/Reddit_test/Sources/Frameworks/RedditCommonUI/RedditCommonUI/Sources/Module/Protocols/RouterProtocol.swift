//
//  CoordinatorRouterProtocol.swift
//  Reddit_test
//
//  Created by Artem Belenkov on 12.02.2020.
//  Copyright © 2020 Artem Belenkov. All rights reserved.
//

import UIKit
import RedditCommon

public protocol CoordinatorRouterProtocol: PresentableProtocol {
    var rootViewController: UIViewController { get }

    func showScreen(_ module: PresentableProtocol)
    
    func present(_ module: PresentableProtocol)
    func present(_ module: PresentableProtocol, style: UIModalPresentationStyle)
    func present(_ module: PresentableProtocol, animated: Bool, style: UIModalPresentationStyle)
    
    func push(_ module: PresentableProtocol)
    func push(_ module: PresentableProtocol, hideBottomBar: Bool)
    func push(_ module: PresentableProtocol, animated: Bool)
    func push(_ module: PresentableProtocol, animated: Bool, completion: EmptyBlock?)
    func push(_ module: PresentableProtocol, animated: Bool, hideBottomBar: Bool, completion: EmptyBlock?)
    
    func popModule()
    func popModule(animated: Bool)
    
    func dismissModule()
    func dismissModule(animated: Bool, completion: EmptyBlock?)
    
    func popToRootModule(animated: Bool)
}

extension CoordinatorRouterProtocol {
    public func present(_ module: PresentableProtocol) {
        present(module, style: .overFullScreen)
    }
    
    public func present(_ module: PresentableProtocol, style: UIModalPresentationStyle) {
        present(module, animated: true, style: style)
    }
    
    public func present(_ module: PresentableProtocol, animated: Bool, style: UIModalPresentationStyle) {
        guard let controller = module.toPresent() else {
            return
        }
        controller.modalPresentationStyle = style
        rootViewController.present(controller, animated: animated, completion: nil)
    }
    
    public func dismissModule() {
        dismissModule(animated: true, completion: nil)
    }
    
    public func dismissModule(animated: Bool, completion: EmptyBlock?) {
        rootViewController.dismiss(animated: animated, completion: { completion?.execute(()) })
    }
    
    public func push(_ module: PresentableProtocol) {
        push(module, animated: true)
    }
    
    public func push(_ module: PresentableProtocol, hideBottomBar: Bool) {
        push(module, animated: true, hideBottomBar: hideBottomBar, completion: nil)
    }
    
    public func push(_ module: PresentableProtocol, animated: Bool) {
        push(module, animated: animated, completion: nil)
    }
    
    public func push(_ module: PresentableProtocol, animated: Bool, completion: EmptyBlock?) {
        push(module, animated: animated, hideBottomBar: false, completion: completion)
    }
    
    public func popModule() {
        popModule(animated: true)
    }
        
    // MARK: PresentableProtocol
    public func toPresent() -> UIViewController? { rootViewController }
}
