//
//  NetworkingManager.swift
//  Reddit_test
//
//  Created by Artem Belenkov on 11.02.2020.
//  Copyright © 2020 Artem Belenkov. All rights reserved.
//

import RedditCommon
import Foundation

public protocol NetworkingManagerProtocol {
    func sendGetRequest<RESPONSE: ResponseProtocol>(request: RequestProtocol,
                                                    successBlock: BlockObject<RESPONSE, Void>,
                                                    errorBlock: BlockObject<Error, Void>) -> CancellableProtocol?
}

public final class NetworkingManager: NetworkingManagerProtocol {
    public typealias ServiceLocator = NetworkSessionServiceLocator & URLTaskProcessorServiceLocator & DataTasksHolderServiceLocator & ReachabilityServiceLocator
    public final class ServiceLocatorImpl: ServiceLocator {
        public init() {}
    }
    
    private let syncQueue: DispatchQueue
    private let tasksHolder: DataTasksHolderProtocol
    private let urlTaskProcessor: URLTaskProcessorProtocol
    private let reachability: ReachabilityProtocol.Type
    
    deinit {
        tasksHolder.cancelAll()
    }
    
    public init(serviceLocator: ServiceLocator = ServiceLocatorImpl(), syncQueue: DispatchQueue = .main) {
        self.syncQueue = syncQueue
        self.urlTaskProcessor = serviceLocator.taskProcessor(session: serviceLocator.networkSession())
        self.tasksHolder = serviceLocator.dataTasksHolder()
        self.reachability = serviceLocator.reachabilityService()
    }
    
    public func sendGetRequest<RESPONSE: ResponseProtocol>(request: RequestProtocol,
                                                           successBlock: BlockObject<RESPONSE, Void>,
                                                           errorBlock: BlockObject<Error, Void>) -> CancellableProtocol? {
        guard reachability.isConnectedToNetwork() else {
            syncQueue.async {
                errorBlock.execute(NetworkingError.noConnection)
            }
            return nil
        }
        
        guard let url = request.urlComponents.url else {
            syncQueue.async {
                errorBlock.execute(NetworkingError.wrongURL)
            }
            return nil
        }
        
        let identifier = UUID().uuidString
        
        let successBlock = BlockObject<RESPONSE, Void> { [weak self] response in
            self?.tasksHolder.remove(identifier)
            self?.syncQueue.async {
                successBlock.execute(response)
            }
        }
        let errorBlock = BlockObject<Error, Void> { [weak self] error in
            self?.tasksHolder.remove(identifier)
            self?.syncQueue.async {
                errorBlock.execute(error)
            }
        }
        let cancelBlock = EmptyBlock { [weak self] in
            self?.tasksHolder.cancel(identifier)
        }
        
        let task = urlTaskProcessor.createTask(url: url,
                                               identifier: identifier,
                                               successBlock: successBlock,
                                               errorBlock: errorBlock,
                                               cancelBlock: cancelBlock)
        
        tasksHolder.add(task)
        task.resume()
        
        return task
    }
}
