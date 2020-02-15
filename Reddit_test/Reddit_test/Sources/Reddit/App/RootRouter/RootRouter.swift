//
//  RootRouter.swift
//  Reddit_test
//
//  Created by Artem Belenkov on 12.02.2020.
//  Copyright © 2020 Artem Belenkov. All rights reserved.
//

import UIKit
import RedditCommonUI

final class RootRouter: CoordinatorRouter {
    private var window: UIWindow?
    
    override init(_ rootViewController: UIViewController = UIViewController()) {
        super.init(rootViewController)
        
        // Setup window
        window = UIWindow()
        rootViewController.restorationIdentifier = "rootViewController"
        window?.rootViewController = rootViewController
        window?.backgroundColor = .white
        window?.makeKeyAndVisible()
    }
}
