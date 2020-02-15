//
//  Module.swift
//  Reddit_test
//
//  Created by Artem Belenkov on 12.02.2020.
//  Copyright © 2020 Artem Belenkov. All rights reserved.
//

import UIKit

public struct Module<Input, Output>: PresentableProtocol {
    public var view: UIViewController
    public var input: Input
    public var output: Output?
    
    public init(view: UIViewController, input: Input, output: Output?) {
        self.input = input
        self.output = output
        self.view = view
    }
    
    public func toPresent() -> UIViewController? { view }
}
