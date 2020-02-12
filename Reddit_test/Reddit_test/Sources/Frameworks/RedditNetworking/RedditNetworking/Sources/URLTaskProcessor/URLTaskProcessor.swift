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

final class URLTaskProcessor: URLTaskProcessorProtocol {
    typealias ServiceLocator = NetworkSessionServiceLocator
    final class ServiceLocatorImpl: ServiceLocator {}
    
    private let session: NetworkSessionProtocol
    
    init(serviceLocator: ServiceLocator = ServiceLocatorImpl()) {
        self.session = serviceLocator.networkSession()
    }
    
    func createTask<RESPONSE: ResponseProtocol>(url: URL,
                                                identifier: String,
                                                successBlock: BlockObject<RESPONSE, Void>,
                                                errorBlock: BlockObject<Error, Void>,
                                                cancelBlock: EmptyBlock) -> DataTaskProtocol {
        var optionalDataTask: DataTaskProtocol?
        let task = session.networkingDataTask(with: url, identifier: identifier, completionHandler: { [weak self] data, response, error in
            guard let self = self, optionalDataTask?.isCanceled != true else {
                return
            }
            
            do {
                let httpResponse = try self.handleDataTaskResponse(response, error)
                let responseObject: RESPONSE = try self.responseObject(data, httpResponse)
                successBlock.execute(responseObject)
            } catch {
                errorBlock.execute(error)
            }
        }, cancelBlock: cancelBlock)
        
        optionalDataTask = task
        return task
    }
    
    private func handleDataTaskResponse(_ response: URLResponse?, _ error: Error?) throws -> HTTPURLResponse {
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
        
        return response
    }
    
    private func responseObject<RESPONSE: ResponseProtocol>(_ data: Data?,
                                                            _ response: HTTPURLResponse) throws -> RESPONSE {
        try RESPONSE.responseObject(data, response)
    }
}
