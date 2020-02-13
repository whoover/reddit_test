//
//  TopicsListModuleViewController.swift
//  Reddit_test
//
//  Created by Artem Belenkov on 13/02/2020
//  Copyright © 2020 Artem Belenkov. All rights reserved.
//

import UIKit

class TopicsListModuleViewController: UIViewController, ViewControllerProtocol {
    @IBOutlet private weak var tableViewContainer: UIView!
    
    var output: TopicsListModuleViewOutput?
    
    private var tableViewController: BaseTableViewController<RedditTopicDataSource>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubviews()
        output?.viewDidLoad()
    }
}

// MARK: - Configure
extension TopicsListModuleViewController: TopicsListModuleViewInput {
    private func setupSubviews() {
        tableViewController = BaseTableViewController<RedditTopicDataSource>(cellsDelegate: self,
                                                                             cellsToRegister: [RedditTopicCell.self])
        addChildController(tableViewController, tableViewContainer, { $0.fillSuperview() })
    }
}

// MARK: View Input
extension TopicsListModuleViewController {
    func set(title: String) {
        self.title = title
    }
}

// MARK: Button Action
extension TopicsListModuleViewController {
    
}
