//
//  TableViewDataSourceModelProtocol.swift
//  Reddit_test
//
//  Created by Artem Belenkov on 10.02.2020.
//  Copyright © 2020 Artem Belenkov. All rights reserved.
//

import UIKit

//TODO: add associated types to these protocols after moving to swift.
//      it isn't possible for now as swift generics can't be used in obj-c.
public protocol TableViewDataSourceModelProtocol {
    static var editingStyle: UITableViewCell.EditingStyle { get }
    static var shouldIndentWhileEditing: Bool { get }
    static var canMoveCells: Bool { get }

    var sections: [TableViewSectionModelProtocol] { get set }
}

public extension TableViewDataSourceModelProtocol {
    static var editingStyle: UITableViewCell.EditingStyle { .none }

    static var shouldIndentWhileEditing: Bool { false }

    static var canMoveCells: Bool { false }

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

    mutating func move(_ fromIndexPath: IndexPath, _ toIndexPath: IndexPath) {
        let model = sections[fromIndexPath.section].cells[fromIndexPath.row]
        sections[fromIndexPath.section].cells.remove(at: fromIndexPath.row)
        sections[toIndexPath.section].cells.insert(model, at: toIndexPath.row)
    }
}

public protocol TableViewSectionModelProtocol {
    static var headerHeight: CGFloat { get }

    var cells: [CellModelProtocol] { get set }
}

public protocol MovingAcceptSectionModelProtocol {
    var acceptInsertMovingCells: Bool { get set }
    var notAcceptedIndexes: [Int] { get }
}

public protocol CustomHeaderSectionModelProtocol: TableViewSectionModelProtocol {
    var header: SectionHeader { get set }
}

public extension TableViewSectionModelProtocol {
    static var headerHeight: CGFloat { 0 }
}

public protocol SectionHeader {}
extension String: SectionHeader {}
extension UIView: SectionHeader {}
