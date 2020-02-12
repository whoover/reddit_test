//
//  UITableView+AnyCollectionProtocol.swift
//  Reddit_test
//
//  Created by Artem Belenkov on 10.02.2020.
//  Copyright © 2020 Artem Belenkov. All rights reserved.
//

import UIKit

extension UITableView: AnyCollectionProtocol {
    public func registerCell(_ cellClass: AnyClass?, forCellReuseIdentifier identifier: String) {
        register(cellClass, forCellReuseIdentifier: identifier)
    }
    
    public func registerCell(_ nib: UINib?, forCellReuseIdentifier identifier: String) {
        register(nib, forCellReuseIdentifier: identifier)
    }
    
    public func dequeueCell(_ cellClass: CellProtocol.Type, _ indexPath: IndexPath) -> CellProtocol {
        dequeueReusableCell(withIdentifier: cellClass.identifier, for: indexPath)
    }
    
    public func dequeueCell(_ cellModel: CellModelProtocol, _ indexPath: IndexPath) -> CellProtocol {
        dequeueCell(type(of: cellModel).cellClass, indexPath)
    }
}
