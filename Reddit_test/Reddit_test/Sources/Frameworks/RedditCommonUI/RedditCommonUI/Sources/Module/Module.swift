//
//  Module.swift
//  Reddit_test
//
//  Created by Artem Belenkov on 12.02.2020.
//  Copyright © 2020 Artem Belenkov. All rights reserved.
//

import UIKit

struct Module<Input, Output>: PresentableProtocol {
    var view: UIViewController
    var input: Input
    var output: Output?
    
    func toPresent() -> UIViewController {
        view
    }
}
