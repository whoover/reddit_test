//
//  NetworkingManager.swift
//  Reddit_test
//
//  Created by Artem Belenkov on 11.02.2020.
//  Copyright © 2020 Artem Belenkov. All rights reserved.
//

import RedditCommon
import Foundation

public class NetworkingManager {
    private let syncQueue: DispatchQueue
    private let tasksHolder = DataTasksHolder()
    private let urlTaskProcessor: URLTaskProcessor
    
    deinit {
        tasksHolder.cancelAll()
    }
    
    public init(session: URLSession = .shared, syncQueue: DispatchQueue = .main) {
        self.syncQueue = syncQueue
        self.urlTaskProcessor = URLTaskProcessor(session: session, syncQueue: syncQueue)
    }
    
    public func sendGetRequest<RESPONSE: ResponseProtocol>(request: RequestProtocol,
                                                           successBlock: BlockObject<RESPONSE, Void>,
                                                           errorBlock: BlockObject<Error, Void>) -> CancellableProtocol? {
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
        
        var dataTask: CancellableProtocol?
        let task = urlTaskProcessor.createTask(url: url, isCanceledBlock: isCanceledBlock(dataTask), successBlock: successBlock, errorBlock: errorBlock)
        
        let cancelBlock = EmptyBlock { [weak self] in
            self?.tasksHolder.cancel(identifier)
        }
        dataTask = DataTask(task: task, identifier: identifier, cancelBlock: cancelBlock)
        tasksHolder.add(dataTask)
        
        return dataTask
    }
    
    private func isCanceledBlock(_ dataTask: CancellableProtocol?) -> BlockObject<(), Bool> {
        return BlockObject<(), Bool> {
            return dataTask?.isCanceled == true
        }
    }
}
