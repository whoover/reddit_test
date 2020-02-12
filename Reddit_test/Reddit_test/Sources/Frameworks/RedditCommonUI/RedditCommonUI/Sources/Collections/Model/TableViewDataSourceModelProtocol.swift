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
    
    static var editingStyle: UITableViewCell.EditingStyle { get }
    static var shouldIndentWhileEditing: Bool { get }
    
    var sections: [SECTION] { get set }
}

extension TableViewDataSourceModelProtocol {
    public static var editingStyle: UITableViewCell.EditingStyle { .none }
    public static var shouldIndentWhileEditing: Bool { false }
    
    func uniqueCellClasses() -> [CellProtocol.Type] {
        sections
        .flatMap { $0.cells }
        .map { type(of: $0).cellClass }
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
    static var headerHeight: CGFloat { get }

    var cells: [CELL] { get set }
}

public protocol CustomHeaderSectionModelProtocol {
    var header: SectionHeader { get set }
}

public extension TableViewSectionModelProtocol {
    static var headerHeight: CGFloat { 0 }
}

public protocol SectionHeader {}
extension String: SectionHeader {}
extension UIView: SectionHeader {}
