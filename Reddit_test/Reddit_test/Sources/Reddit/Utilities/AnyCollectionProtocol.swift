//
//  AnyCollectionProtocol.swift
//  Reddit_test
//
//  Created by Artem Belenkov on 10.02.2020.
//  Copyright © 2020 Artem Belenkov. All rights reserved.
//

import UIKit
//import SwiftCommon

public protocol AnyCollectionProtocol {
    func registerCellClasses(_ cellClasses: [CellProtocol.Type])
    func registerCellClass(_ cellClass: CellProtocol.Type)
    func dequeueCell(_ cellClass: CellProtocol.Type, _ indexPath: IndexPath) -> CellProtocol
    func dequeueCell(_ cellModel: CellModelProtocol, _ indexPath: IndexPath) -> CellProtocol
    
    //Native methods
    func registerCell(_ cellClass: AnyClass?, forCellReuseIdentifier identifier: String)
    func registerCell(_ nib: UINib?, forCellReuseIdentifier identifier: String)
}

public extension AnyCollectionProtocol {
    func registerCellClasses(_ cellClasses: [CellProtocol.Type]) {
        cellClasses.forEach { registerCellClass($0) }
    }

    func registerCellClass(_ cellClass: CellProtocol.Type) {
        let bundle = Bundle(for: cellClass)
        guard bundle.path(forResource: cellClass.nibName, ofType: "nib") != nil ||
            bundle.path(forResource: cellClass.nibName, ofType: "xib") != nil else {
            registerCell(cellClass, forCellReuseIdentifier: cellClass.identifier)
            return
        }

        guard let uniqNibLoadable = cellClass as? UniqNibLoadableProtocol.Type else {
            registerCell(cellClass.nib, forCellReuseIdentifier: cellClass.identifier)
            return
        }

        registerCell(uniqNibLoadable.uniqNib, forCellReuseIdentifier: cellClass.identifier)
    }
}
