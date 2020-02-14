//
//  UICollectionView+AnyCollectionProtocol.swift
//  Reddit_test
//
//  Created by Artem Belenkov on 10.02.2020.
//  Copyright © 2020 Artem Belenkov. All rights reserved.
//

import UIKit

extension UICollectionView: AnyCollectionProtocol {
    public func dequeueCell(_ cellClass: CellProtocol.Type, _ indexPath: IndexPath) -> CellProtocol {
        dequeueReusableCell(withReuseIdentifier: cellClass.identifier, for: indexPath)
    }
    
    public func registerCell(_ cellClass: AnyClass?, forCellReuseIdentifier identifier: String) {
        register(cellClass, forCellWithReuseIdentifier: identifier)
    }
    
    public func registerCell(_ nib: UINib?, forCellReuseIdentifier identifier: String) {
        register(nib, forCellWithReuseIdentifier: identifier)
    }
    
    public func dequeueCell(_ cellModel: CellModelProtocol, _ indexPath: IndexPath) -> CellProtocol {
        dequeueCell(cellModel.cellClass, indexPath)
    }
}
