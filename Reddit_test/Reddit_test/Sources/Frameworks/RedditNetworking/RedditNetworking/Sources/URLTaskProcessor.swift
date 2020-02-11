//
//  URLTaskProcessor.swift
//  RedditNetworking
//
//  Created by Artem Belenkov on 11/02/2020.
//  Copyright © 2020 Artem Belenkov. All rights reserved.
//

import RedditCommon

class URLTaskProcessor {
    private let session: URLSession
    private let syncQueue: DispatchQueue
    
    init(session: URLSession = .shared, syncQueue: DispatchQueue = .main) {
        self.session = session
        self.syncQueue = syncQueue
    }
    
    func createTask<RESPONSE: ResponseProtocol>(url: URL,
                                                isCanceledBlock: BlockObject<(), Bool>,
                                                successBlock: BlockObject<RESPONSE, Void>,
                                                errorBlock: BlockObject<Error, Void>) -> URLSessionTask {
        let task = session.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self, !isCanceledBlock.execute(()) else {
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
        
        return task
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
