//
//  URLTaskProcessor.swift
//  RedditNetworking
//
//  Created by Artem Belenkov on 11/02/2020.
//  Copyright © 2020 Artem Belenkov. All rights reserved.
//

import RedditCommon

public protocol URLTaskProcessorProtocol {
    func createTask<RESPONSE: ResponseProtocol>(url: URL,
                                                identifier: String,
                                                successBlock: BlockObject<RESPONSE, Void>,
                                                errorBlock: BlockObject<Error, Void>,
                                                cancelBlock: EmptyBlock) -> DataTaskProtocol
}

class URLTaskProcessor: URLTaskProcessorProtocol {
    typealias ServiceLocatorAlias = NetworkSessionServiceLocator
    private class ServiceLocatorImpl: ServiceLocatorAlias {}
    
    private let session: NetworkSessionProtocol
    private let syncQueue: DispatchQueue
    
    init(session: NetworkSessionProtocol = ServiceLocatorImpl.networkSession(),
         syncQueue: DispatchQueue) {
        self.session = session
        self.syncQueue = syncQueue
    }
    
    func createTask<RESPONSE: ResponseProtocol>(url: URL,
                                                identifier: String,
                                                successBlock: BlockObject<RESPONSE, Void>,
                                                errorBlock: BlockObject<Error, Void>,
                                                cancelBlock: EmptyBlock) -> DataTaskProtocol {
        var optionalDataTask: DataTaskProtocol?
        let task = session.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self, optionalDataTask?.isCanceled != true else {
                return
            }
            
            do {
                try self.handleDataTaskResponse(response, error)
                let responseObject: RESPONSE = try self.responseObject(data)
                self.syncQueue.async {
                    successBlock.execute(responseObject)
                }
            } catch {
                self.syncQueue.async {
                    errorBlock.execute(error)
                }
            }
        }
        
        let dataTask = DataTask(task: task, identifier: identifier, cancelBlock: cancelBlock)
        optionalDataTask = dataTask
        return dataTask
    }
    
    private func handleDataTaskResponse(_ response: URLResponse?, _ error: Error?) throws {
        guard let response = response as? HTTPURLResponse,
            let httpResponse = HTTPResponse(value: response.statusCode) else {
            guard let error = error else {
                throw NetworkingError.unknown
            }
            throw NetworkingError.dataTaskError(error)
        }
        
        guard httpResponse == .success else {
            throw NetworkingError.response(httpResponse)
        }
    }
    
    private func responseObject<RESPONSE: ResponseProtocol>(_ data: Data?) throws -> RESPONSE {
        return try RESPONSE.responseObject(data)
    }
}
