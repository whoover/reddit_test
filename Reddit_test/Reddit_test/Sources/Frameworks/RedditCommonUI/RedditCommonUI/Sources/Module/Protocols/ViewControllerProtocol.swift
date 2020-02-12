//
//  ViewControllerProtocol.swift
//  Reddit_test
//
//  Created by Artem Belenkov on 12.02.2020.
//  Copyright © 2020 Artem Belenkov. All rights reserved.
//

import UIKit

public protocol ViewControllerProtocol: UIViewController { }
extension UIViewController: PresentableProtocol {
    public func toPresent() -> UIViewController { self }
}
