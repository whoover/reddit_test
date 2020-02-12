//
//  CellModelProtocol.swift
//  Reddit_test
//
//  Created by Artem Belenkov on 10.02.2020.
//  Copyright © 2020 Artem Belenkov. All rights reserved.
//

import UIKit

@objc public protocol CellModelObjcProtocol {}

public protocol CellModelProtocol: CellModelObjcProtocol {
    static var cellClass: CellProtocol.Type { get }
    static var cellHeight: CGFloat { get }
}

public extension CellModelProtocol {
    static var cellHeight: CGFloat { 44.0 }
}

public protocol AccessabilityElementProtocol {
    var accessabilityIdentifier: String? { get set }
}

public protocol IndividualMovableProtocol {
    var canBeMoved: Bool { get set }
}

public protocol ActionCellProtocol {
    var actionHandler: (() -> Void)? { get set }
}

public protocol IndividualHeightProtocol {
    var individualHeight: CGFloat { get set }
}

public protocol ViewWithSeparatorModelProtocol {
    var showSeparator: Bool { get set }
}
