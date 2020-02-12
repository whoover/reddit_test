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

public class NetworkingManager: NetworkingManagerProtocol {
    typealias ServiceLocatorAlias = NetworkSessionServiceLocator & URLTaskProcessorServiceLocator & DataTasksHolderServiceLocator
    public class ServiceLocatorImpl: ServiceLocatorAlias {}
    
    private let syncQueue: DispatchQueue
    private let tasksHolder: DataTasksHolderProtocol
    private let urlTaskProcessor: URLTaskProcessorProtocol
    
    deinit {
        tasksHolder.cancelAll()
    }
    
    public init(session: NetworkSessionProtocol = ServiceLocatorImpl.networkSession(),
                syncQueue: DispatchQueue = .main) {
        self.syncQueue = syncQueue
        self.urlTaskProcessor = ServiceLocatorImpl.taskProcessor(session: session, syncQueue: syncQueue)
        self.tasksHolder = ServiceLocatorImpl.dataTasksHolder()
    }
    
    public func sendGetRequest<RESPONSE: ResponseProtocol>(request: RequestProtocol,
                                                           successBlock: BlockObject<RESPONSE, Void>,
                                                           errorBlock: BlockObject<Error, Void>) -> CancellableProtocol? {
        guard let reachability = try? Reachability(),
            reachability.connection != .unavailable else {
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
            successBlock.execute(response)
        }
        let errorBlock = BlockObject<Error, Void> { [weak self] error in
            self?.tasksHolder.remove(identifier)
            errorBlock.execute(error)
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
