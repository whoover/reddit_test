//
//  TopicsListModulePresenter.swift
//  Reddit_test
//
//  Created by Artem Belenkov on 13/02/2020
//  Copyright © 2020 Artem Belenkov. All rights reserved.
//

import Foundation
import RedditCoreServices

class TopicsListModulePresenter: BasePresenter
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
    func loadImage(_ imageURL: URL, _ completionBlock: BlockObject<LoadedImage?, Void>) -> CancellableProtocol? {
        interactor.loadImage(imageURL, completionBlock)
    }
    
    func loadDataFromStorage() {
        let successBlock = BlockObject<[RedditTopicModel], Void> { [weak self] models in
            self?.modelsLoaded(models)
        }
        interactor.onStart(completionBlock: successBlock)
    }
    
    func viewDidLoad() {
        setupDataSource()
        view?.set(title: "TopicsListModule")
        
        let successBlock = BlockObject<[RedditTopicModel], Void> { [weak self] models in
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
        interactor.reloadTopics(progressBlock: progressBlock)
    }
    
    private func modelsLoaded(_ models: [RedditTopicModel]) {
        dataSource.sections.first?.cells.append(contentsOf: models.map { RedditTopicCellModel(model: $0) })
        view?.finishedLoading()
        view?.reloadData()
    }
}
