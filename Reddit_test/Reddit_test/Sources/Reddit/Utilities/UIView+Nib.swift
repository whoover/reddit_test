//
//  UIView+Nib.swift
//  Reddit_test
//
//  Created by Artem Belenkov on 10.02.2020.
//  Copyright © 2020 Artem Belenkov. All rights reserved.
//

import UIKit

public protocol NibLoadableProtocol: class {
    static var nib: UINib { get }
    static var nibName: String { get }
    
    static func loadFromNib() -> Self?
}

public extension NibLoadableProtocol {
    static var nibName: String { String(describing: self) }

    static var nib: UINib { UINib(nibName: nibName, bundle: Bundle(for: self)) }
}

public extension NibLoadableProtocol where Self: UIView {
    static func loadFromNib() -> Self? { nib.instantiate(withOwner: nil, options: nil).first as? Self }
}

public extension NibLoadableProtocol where Self: UIViewController {
    @discardableResult
    static func loadFromNib() -> Self? { self.init(nibName: nibName, bundle: Bundle(for: self)) }
}

public protocol UniqNibLoadableProtocol: class {
    static var uniqNibName: String { get }
    static var uniqNib: UINib { get }
}

extension UIView: NibLoadableProtocol {}
extension UIViewController: NibLoadableProtocol {}
