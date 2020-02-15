//
//  TopicsListModuleViewController.swift
//  Reddit_test
//
//  Created by Artem Belenkov on 13/02/2020
//  Copyright © 2020 Artem Belenkov. All rights reserved.
//

import UIKit
import RedditCoreServices

class TopicsListModuleViewController: UIViewController, ViewControllerProtocol {
    @IBOutlet private weak var tableViewContainer: UIView!
    
    var output: TopicsListModuleViewOutput?
    
    private var tableViewController: BaseTableViewController<RedditTopicDataSource>!
    private var backgroundColor: UIColor?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubviews()
        setupRefreshControl()
        
        output?.viewDidLoad()
        tableViewController.tableView.contentInsetAdjustmentBehavior = .never
        tableViewController.dataSourceModel = output?.dataSource
        tableViewController.tableView.backgroundColor = backgroundColor
        view.backgroundColor = backgroundColor
        restorationIdentifier = "TopicsListModuleViewController"
    }
    
    private func setupRefreshControl() {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(reloadTopics), for: .valueChanged)
        tableViewController.tableView.refreshControl = refreshControl
    }
    
    @objc private func reloadTopics() {
        output?.reloadTopics()
    }
    
    func setupTheme(_ theme: TopicThemeProtocol) {
        self.backgroundColor = theme.backgroundColor
    }
}

// MARK: - Configure
extension TopicsListModuleViewController: TopicsListModuleViewInput {
    func showLoadingIndicator() {
        let activity = UIActivityIndicatorView(style: .large)
        activity.color = .black
        activity.startAnimating()
        tableViewController.tableView.backgroundView = activity
    }
    
    func finishedLoading() {
        tableViewController.tableView.refreshControl?.endRefreshing()
        tableViewController.tableView.backgroundView = nil
    }
    
    func reloadData() {
        tableViewController.reloadData()
    }
    
    private func setupSubviews() {
        tableViewController = BaseTableViewController<RedditTopicDataSource>(cellsDelegate: self,
                                                                             cellsToRegister: [RedditTopicCell.self, RedditTopicWithoutImageCell.self])
        tableViewController.delegate = self
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

extension TopicsListModuleViewController: RedditTopicCellDelegate {
    func openImage(_ identifier: UUID) {
        output?.wantsOpenImage(identifier)
    }
    
    func loadImage(_ imageURL: URL, _ identifier: UUID, _ completionBlock: BlockObject<LoadedImage?, Void>) -> CancellableProtocol? {
        output?.loadImage(imageURL, completionBlock)
    }
}

extension TopicsListModuleViewController: BaseTableViewControllerDelegate {
    func baseTableViewController(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if output?.dataSource.sections[indexPath.section].cells.count == indexPath.row + 1 {
            output?.loadMoreData()
        }
    }
}
