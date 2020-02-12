//
//  UIViewController+Additions.swift
//  Reddit_test
//
//  Created by Artem Belenkov on 12.02.2020.
//  Copyright © 2020 Artem Belenkov. All rights reserved.
//

import UIKit

extension UIViewController {
    func addChildController(_ viewController: UIViewController, _ constraintsBlock: (_ view: UIView) -> Void) {
		viewController.willMove(toParent: self)
		addChild(viewController)
		view.addSubview(viewController.view)
        constraintsBlock(viewController.view)
		viewController.didMove(toParent: self)
	}
}
