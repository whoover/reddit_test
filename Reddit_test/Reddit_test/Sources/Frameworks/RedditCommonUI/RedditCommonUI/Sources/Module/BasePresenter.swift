//
//  BasePresenter.swift
//  Reddit_test
//
//  Created by Artem Belenkov on 12.02.2020.
//  Copyright © 2020 Artem Belenkov. All rights reserved.
//

import UIKit
import RedditCommon

open class BasePresenter<O, I, R, V> {
    public let interactor: I
    public let router: R
    private let viewWeakContainer: WeakContainer<V>
    private let moduleOutputWeakContainer: WeakContainer<O>?
    
    public var view: V? { viewWeakContainer.value }
    
    public var moduleOutput: O? { moduleOutputWeakContainer?.value }
    
    public init(interactor: I, router: R, view: V, moduleOutput: O?) {
        self.interactor = interactor
        self.router = router
        self.viewWeakContainer = WeakContainer(value: view)
        if let moduleOutput = moduleOutput {
            moduleOutputWeakContainer = WeakContainer(value: moduleOutput)
        } else {
            moduleOutputWeakContainer = nil
        }
    }
}
