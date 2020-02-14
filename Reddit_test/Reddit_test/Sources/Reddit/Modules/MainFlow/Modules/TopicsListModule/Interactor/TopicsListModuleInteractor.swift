//
//  TopicsListModuleInteractor.swift
//  Reddit_test
//
//  Created by Artem Belenkov on 13/02/2020
//  Copyright © 2020 Artem Belenkov. All rights reserved.
//

import Foundation
import RedditNetworking
import RedditCoreServices

final class TopicsListModuleInteractor {
    typealias ServiceLocator = NetworkingManagerServiceLocator & DataStorageServiceLocator & AddapterServiceLocator & ImageDownloadServiceLocatorProtocol
    final class ServiceLocatorImpl: ServiceLocator {}
        
    private let networkingManager: NetworkingManagerProtocol
    private let dataStorage: DataStorageProtocol
    private let dataAddapter: AddapterServiceProtocol
    private let imageDownloader: ImageDownloadServiceProtocol
    private let backgroundQueue = DispatchQueue(label: "com.reddittest.TopicsListModuleInteractor.backgroundQueue")
    private var lastRequest: CancellableProtocol?
    private var fullyLoaded: Bool = false
    
    init(serviceLocator: ServiceLocator = ServiceLocatorImpl()) {
        self.networkingManager = serviceLocator.networkingManager(syncQueue: backgroundQueue)
        self.dataStorage = serviceLocator.dataStorage()
        self.dataAddapter = serviceLocator.addapter()
        self.imageDownloader = serviceLocator.imageDownloadService()
    }
}

// MARK: Private
extension TopicsListModuleInteractor: TopicsListModuleInteractorInput {
    func loadImage(_ imageURL: URL, _ completionBlock: BlockObject<LoadedImage?, Void>) -> CancellableProtocol? {
        imageDownloader.downloadImage(with: imageURL, completionBlock: completionBlock)
    }
    
    func loadTopics(progressBlock: BlockObject<TopicsScreenState, Void>) {
        guard !fullyLoaded, lastRequest == nil else {
            return
        }
        
        progressBlock.execute(.loading)
        let successBlock = BlockObject<RedditResponse, Void> { [weak self] response in
            guard let self = self else {
                return
            }
            let models = self.dataAddapter.addapt(response)
            
            DispatchQueue.main.async {
                progressBlock.execute(.dataLoaded(models))
                self.lastRequest = nil
                self.fullyLoaded = models.isEmpty
            }
            
            var storedItems: [RedditTopicModel] = self.dataStorage.getItems()
            storedItems.append(contentsOf: models)
            self.dataStorage.save(items: storedItems)
            self.dataStorage.save(after: response.data.after)
        }
        
        let errorBlock = BlockObject<Error, Void> { error in
            DispatchQueue.main.async {
                progressBlock.execute(.error(error))
            }
        }
        
        lastRequest = networkingManager.sendGetRequest(request: RedditRequest.top(dataStorage.getAfter()),
                                                       successBlock: successBlock,
                                                       errorBlock: errorBlock)
    }
    
    func reloadTopics(progressBlock: BlockObject<TopicsScreenState, Void>) {
        dataStorage.cleanupData()
        loadTopics(progressBlock: progressBlock)
    }
    
    func onStart(completionBlock: BlockObject<[RedditTopicModel], Void>) {
        let items: [RedditTopicModel] = dataStorage.getItems()
        completionBlock.execute(items)
    }
}
