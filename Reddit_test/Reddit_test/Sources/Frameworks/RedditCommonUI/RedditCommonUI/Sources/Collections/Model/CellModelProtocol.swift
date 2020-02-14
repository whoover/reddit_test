//
//  CellModelProtocol.swift
//  Reddit_test
//
//  Created by Artem Belenkov on 10.02.2020.
//  Copyright © 2020 Artem Belenkov. All rights reserved.
//

import UIKit

public protocol CellModelProtocol {
    static var cellHeight: CGFloat { get }
    var cellClass: CellProtocol.Type { get }
}

public extension CellModelProtocol {
    static var cellHeight: CGFloat { 44.0 }
}

public protocol AccessabilityElementProtocol {
    var accessabilityIdentifier: String? { get set }
}

public protocol ActionCellProtocol {
    var actionHandler: (() -> Void)? { get set }
}

public protocol IndividualHeightProtocol {
    var individualHeight: CGFloat { get set }
}
