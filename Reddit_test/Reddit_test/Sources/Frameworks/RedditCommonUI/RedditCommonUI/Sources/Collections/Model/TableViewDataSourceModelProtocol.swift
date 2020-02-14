//
//  TableViewDataSourceModelProtocol.swift
//  Reddit_test
//
//  Created by Artem Belenkov on 10.02.2020.
//  Copyright © 2020 Artem Belenkov. All rights reserved.
//

import UIKit

public protocol TableViewDataSourceModelProtocol {
    associatedtype SECTION: TableViewSectionModelProtocol
    
    var sections: [SECTION] { get set }
}

extension TableViewDataSourceModelProtocol {
    func uniqueCellClasses() -> [CellProtocol.Type] {
        sections
        .flatMap { $0.cells }
            .map { $0.cellClass }
        .reduce([], {
            var containsClass = false
            for cellClass in $0 {
                if String(describing: cellClass) == String(describing: $1) {
                    containsClass = true
                    break
                }
            }
            return containsClass ? $0 : $0 + [$1]
        })
    }
}

public protocol TableViewSectionModelProtocol {
    associatedtype CELL: CellModelProtocol
    var cells: [CELL] { get set }
}

public protocol SectionHeader {}
extension String: SectionHeader {}
extension UIView: SectionHeader {}
