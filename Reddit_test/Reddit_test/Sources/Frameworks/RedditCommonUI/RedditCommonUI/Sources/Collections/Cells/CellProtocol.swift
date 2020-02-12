//
//  CellProtocol.swift
//  Reddit_test
//
//  Created by Artem Belenkov on 10.02.2020.
//  Copyright © 2020 Artem Belenkov. All rights reserved.
//

import UIKit
//import SwiftCommon

public protocol CellProtocol: NibLoadableProtocol {
    static var identifier: String { get }
}

@objc public protocol ConfigurableCellObjcProtocol {
    func configure(_ cellModel: CellModelObjcProtocol, _ delegate: Any?)
}

public protocol ConfigurableCellProtocol: class {
    func configure(_ cellModel: CellModelProtocol, _ delegate: Any?)
}

public extension ConfigurableCellProtocol {
    func configure(_ cellModel: CellModelProtocol) {
        configure(cellModel, nil)
    }
}

public extension CellProtocol where Self: UIView {
    static var identifier: String { nibName }
}

extension UITableViewCell: CellProtocol {}
extension UICollectionReusableView: CellProtocol {}
