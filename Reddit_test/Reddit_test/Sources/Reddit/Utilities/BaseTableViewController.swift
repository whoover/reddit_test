//
//  BaseTableViewController.swift
//  Reddit_test
//
//  Created by Artem Belenkov on 10.02.2020.
//  Copyright © 2020 Artem Belenkov. All rights reserved.
//

import UIKit

@objc public protocol BaseTableViewControllerDelegate: class {
    @objc optional
    func baseTableViewControllerDidMoveCell(_ controller: BaseTableViewController,
                                            _ fromIndexPath: IndexPath,
                                            _ toIndexPath: IndexPath)

    @objc optional
    func baseTableViewController(_ controller: BaseTableViewController,
                                 willDisplay cell: UITableViewCell,
                                 forRowAt indexPath: IndexPath)
    @objc optional
    func baseTableViewController(_ controller: BaseTableViewController,
                                 willDisplayHeaderView view: UIView,
                                 forSection section: Int)

    @objc optional
    func baseTableViewController(_ controller: BaseTableViewController,
                                 prapare cell: UITableViewCell,
                                 forRowAt indexPath: IndexPath)
}

@objc open class BaseTableViewController: UIViewController {
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var tableView: UITableView!
    public weak var delegate: BaseTableViewControllerDelegate?
    public var dataSourceModel: TableViewDataSourceModelProtocol? {
        didSet {
            cellsToRegister.append(contentsOf: (dataSourceModel?.uniqueCellClasses() ?? [])) 
        }
    }
    private var cellsToRegister: [CellProtocol.Type] = []
    private weak var cellsDelegate: AnyObject?

    public init(cellsDelegate: AnyObject? = nil, cellsToRegister: [CellProtocol.Type] = []) {
        self.cellsDelegate = cellsDelegate
        self.cellsToRegister = cellsToRegister
        super.init(nibName: String(describing: type(of: self)), bundle: Bundle(for: type(of: self)))
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override open func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerCellClasses(cellsToRegister)
    }
    
    public func setupTableView(_ setupBlock: ( _ tableView: UITableView) -> Void) {
        setupBlock(tableView)
    }
    
    public func reloadData() {
        tableView.reloadData()
    }
    
    public func cellForRow(at indexPath: IndexPath) -> UITableViewCell? {
        tableView.cellForRow(at: indexPath)
    }
    
    public func indexPath(for cell: UITableViewCell) -> IndexPath? {
        tableView.indexPath(for: cell)
    }
    
    public func moveRow(at indexPath: IndexPath, toIndexPath: IndexPath) {
        tableView.beginUpdates()
        tableView.moveRow(at: indexPath, to: toIndexPath)
        tableView.endUpdates()
        tableView.reloadSections([toIndexPath.section], with: .none)
    }
}

extension BaseTableViewController: UITableViewDelegate, UITableViewDataSource {
    open func numberOfSections(in tableView: UITableView) -> Int {
        dataSourceModel?.sections.count ?? 0
    }

    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        guard let section = dataSourceModel?.sections[section] else {
            return 0
        }
        return (section as? IndividualHeightProtocol)?.individualHeight ?? type(of: section).headerHeight
    }

    open func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        (dataSourceModel?.sections[section] as? CustomHeaderSectionModelProtocol)?.header as? String
    }

    open func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = (dataSourceModel?.sections[section] as? CustomHeaderSectionModelProtocol)?.header as? UIView
        headerView?.accessibilityIdentifier = "base-table_header-\(section)_view"
        return headerView
    }

    open func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataSourceModel?.sections[section].cells.count ?? 0
    }

    open func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let cellModel = dataSourceModel?.sections[indexPath.section].cells[indexPath.row] else {
            return 0.0
        }
        return (cellModel as? IndividualHeightProtocol)?.individualHeight ?? type(of: cellModel).cellHeight
    }

    open func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cellModel = dataSourceModel?.sections[indexPath.section].cells[indexPath.row],
            let cell = tableView.dequeueCell(type(of: cellModel).cellClass, indexPath) as? UITableViewCell else {
            return UITableViewCell()
        }

        (cell as? ConfigurableCellProtocol)?.configure(cellModel, cellsDelegate ?? self)
        if let accessaibilityElementModel = cellModel as? AccessabilityElementProtocol {
           cell.accessibilityIdentifier = accessaibilityElementModel.accessabilityIdentifier
        }
        delegate?.baseTableViewController?(self, prapare: cell, forRowAt: indexPath)

        return cell
    }

    open func tableView(_ tableView: UITableView,
                        editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        guard let dataSourceModel = dataSourceModel else {
            return .none
        }
        return type(of: dataSourceModel).editingStyle
    }

    open func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        guard let dataSourceModel = dataSourceModel else {
            return false
        }
        return type(of: dataSourceModel).shouldIndentWhileEditing
    }

    open func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        guard let dataSourceModel = dataSourceModel else {
            return false
        }
        guard let individualMovableModel = (dataSourceModel.sections[indexPath.section]
            .cells[indexPath.row] as? IndividualMovableProtocol) else {
                return type(of: dataSourceModel).canMoveCells
        }

        return individualMovableModel.canBeMoved
    }

    public func tableView(_ tableView: UITableView,
                          targetIndexPathForMoveFromRowAt sourceIndexPath: IndexPath,
                          toProposedIndexPath proposedDestinationIndexPath: IndexPath) -> IndexPath {
        guard let movingAcceptSectionModel = dataSourceModel?.sections[proposedDestinationIndexPath.section]
            as? MovingAcceptSectionModelProtocol,
            movingAcceptSectionModel.acceptInsertMovingCells else {
            return sourceIndexPath
        }

        guard !movingAcceptSectionModel.notAcceptedIndexes.contains(proposedDestinationIndexPath.row) else {
            return sourceIndexPath
        }

        return proposedDestinationIndexPath
    }

    public func tableView(_ tableView: UITableView,
                          moveRowAt sourceIndexPath: IndexPath,
                          to destinationIndexPath: IndexPath) {
        dataSourceModel?.move(sourceIndexPath, destinationIndexPath)
        delegate?.baseTableViewControllerDidMoveCell?(self, sourceIndexPath, destinationIndexPath)
    }

    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let cellModel = dataSourceModel?.sections[indexPath.section].cells[indexPath.row]
        (cellModel as? ActionCellProtocol)?.actionHandler?()
    }

    public func tableView(_ tableView: UITableView,
                          willDisplay cell: UITableViewCell,
                          forRowAt indexPath: IndexPath) {
        delegate?.baseTableViewController?(self, willDisplay: cell, forRowAt: indexPath)
    }

    public func tableView(_ tableView: UITableView,
                          willDisplayHeaderView view: UIView,
                          forSection section: Int) {
        delegate?.baseTableViewController?(self, willDisplayHeaderView: view, forSection: section)
    }
}
