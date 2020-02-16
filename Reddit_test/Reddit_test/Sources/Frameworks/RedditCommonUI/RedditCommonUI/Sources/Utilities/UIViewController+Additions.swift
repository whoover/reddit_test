//
//  UIViewController+Additions.swift
//  Reddit_test
//
//  Created by Artem Belenkov on 12.02.2020.
//  Copyright © 2020 Artem Belenkov. All rights reserved.
//

import UIKit
import RedditCommon

public extension UIViewController {
    func addChildController(_ viewController: UIViewController, _ constraintsBlock: (_ view: UIView) -> Void) {
        addChildController(viewController, view, constraintsBlock)
	}
    
    func addChildController(_ viewController: UIViewController, _ toSubview: UIView, _ constraintsBlock: (_ view: UIView) -> Void) {
        viewController.willMove(toParent: self)
        addChild(viewController)
        toSubview.addSubview(viewController.view)
        constraintsBlock(viewController.view)
        viewController.didMove(toParent: self)
    }
}

public extension UIViewController {
    private class func instantiateControllerInStoryboard<T: UIViewController>(_ storyboard: UIStoryboard, identifier: String) -> T! {
        storyboard.instantiateViewController(withIdentifier: identifier) as? T
    }
    
    class func controllerInStoryboard(_ storyboard: UIStoryboard, identifier: String) -> Self {
        instantiateControllerInStoryboard(storyboard, identifier: identifier)
    }
    
    class func controllerInStoryboard(_ storyboard: UIStoryboard) -> Self {
        controllerInStoryboard(storyboard, identifier: className)
    }
    
    class func controllerFromStoryboard(_ storyboardName: String) -> Self {
        controllerInStoryboard(UIStoryboard(name: storyboardName, bundle: nil), identifier: className)
    }
}
