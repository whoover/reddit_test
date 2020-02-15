//
//  TopicsListModulePresenter.swift
//  Reddit_test
//
//  Created by Artem Belenkov on 13/02/2020
//  Copyright © 2020 Artem Belenkov. All rights reserved.
//

import Foundation
import RedditCoreServices

final class TopicsListModulePresenter: BasePresenter
<TopicsListModuleOutput,
TopicsListModuleInteractorInput,
TopicsListModuleRouterInputProtocol,
TopicsListModuleViewInput> {
    private(set) var dataSource = RedditTopicDataSource()
}

// MARK: Private
extension TopicsListModulePresenter {
    private func setupDataSource() {
        dataSource.sections.append(RedditTopicSection())
    }
}

// MARK: Module Input
extension TopicsListModulePresenter: TopicsListModuleInput {
    
}

// MARK: View Output
extension TopicsListModulePresenter: TopicsListModuleViewOutput {
    func wantsOpenImage(_ identifier: UUID) {
        let model = dataSource.sections.first?.cells.first(where: { $0.identifier == identifier })
        guard let urlString = model?.fullScreenImageURLString,
            let url = URL(string: urlString) else {
            return
        }
        router.routeForOpenImageAction(url)
    }
    
    func loadMoreData() {
        loadData()
    }
    
    func loadImage(_ imageURL: URL, _ completionBlock: BlockObject<LoadedImage?, Void>) -> CancellableProtocol? {
        interactor.loadImage(imageURL, completionBlock)
    }
    
    func loadDataFromStorage() {
        let successBlock = BlockObject<[RedditTopicCellModel], Void> { [weak self] models in
            self?.modelsLoaded(models)
        }
        interactor.onStart(completionBlock: successBlock)
    }
    
    func viewDidLoad() {
        setupDataSource()
        view?.set(title: "Reddit_test")
        
        let successBlock = BlockObject<[RedditTopicCellModel], Void> { [weak self] models in
            self?.modelsLoaded(models)
            self?.loadData()
        }
        interactor.onStart(completionBlock: successBlock)
    }
    
    func reloadTopics() {
        let progressBlock = BlockObject<TopicsScreenState, Void> { [weak self] state in
            guard let self = self else {
                return
            }
            
            switch state {
            case .loading: ()
            case .error(let error):
                self.view?.finishedLoading()
                self.router.showAlert(title: "Error", message: error.localizedDescription)
            case .dataLoaded(let models):
                self.dataSource.sections.first?.cells = []
                self.modelsLoaded(models)
            }
        }
        interactor.reloadTopics(progressBlock: progressBlock)
    }
    
    func loadData() {
        let progressBlock = BlockObject<TopicsScreenState, Void> { [weak self] state in
            guard let self = self else {
                return
            }
            
            switch state {
            case .loading:
                if self.dataSource.sections.first?.cells.isEmpty == true {
                    self.view?.showLoadingIndicator()
                }
            case .error(let error):
                self.view?.finishedLoading()
                self.router.showAlert(title: "Error", message: error.localizedDescription)
            case .dataLoaded(let models):
                self.modelsLoaded(models)
            }
        }
        interactor.loadTopics(progressBlock: progressBlock)
    }
    
    private func modelsLoaded(_ models: [RedditTopicCellModel]) {
        dataSource.sections.first?.cells.append(contentsOf: models)
        view?.finishedLoading()
        view?.reloadData()
    }
}
