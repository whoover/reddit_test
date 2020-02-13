//
//  BaseTableViewController.swift
//  Reddit_test
//
//  Created by Artem Belenkov on 10.02.2020.
//  Copyright © 2020 Artem Belenkov. All rights reserved.
//

import UIKit

open class BaseTableViewController<DATASOURCE: TableViewDataSourceModelProtocol>: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private(set) public weak var tableView: UITableView!
    public var dataSourceModel: DATASOURCE? {
        didSet {
            cellsToRegister.append(contentsOf: (dataSourceModel?.uniqueCellClasses() ?? [])) 
        }
    }
    private var cellsToRegister: [CellProtocol.Type] = []
    private weak var cellsDelegate: AnyObject?

    public init(cellsDelegate: AnyObject? = nil, cellsToRegister: [CellProtocol.Type] = []) {
        self.cellsDelegate = cellsDelegate
        self.cellsToRegister = cellsToRegister
        super.init(nibName: "BaseTableViewController", bundle: Bundle(for: type(of: self)))
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override open func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
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
    
    open func numberOfSections(in tableView: UITableView) -> Int {
        dataSourceModel?.sections.count ?? 0
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

        return cell
    }

    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let cellModel = dataSourceModel?.sections[indexPath.section].cells[indexPath.row]
        (cellModel as? ActionCellProtocol)?.actionHandler?()
    }
}
