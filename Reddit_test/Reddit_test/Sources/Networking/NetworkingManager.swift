//
//  NetworkingManager.swift
//  Reddit_test
//
//  Created by Artem Belenkov on 11.02.2020.
//  Copyright © 2020 Artem Belenkov. All rights reserved.
//

import Foundation

enum RequestError: Error {
    case noURL
    case responseError(Int)
    case someError(Error)
    case decoding
    case noData
    case unknown
}

class NetworkingManager {
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func sendGetRequest<RESPONSE: ResponseProtocol>(request: RequestProtocol,
                                                    successBlock: BlockObject<RESPONSE, Void>,
                                                    errorBlock: BlockObject<Error, Void>) -> CancellableProtocol? {
        guard let url = request.urlComponents.url else {
            errorBlock.execute(RequestError.noURL)
            return nil
        }
        
        let task = session.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self else {
                return
            }
            do {
                try self.handleDataTaskResponse(response, error)
                successBlock.execute(try self.responseObject(data))
            } catch {
                errorBlock.execute(error)
            }
        }
        task.resume()
        
        return task
    }
    
    private func handleDataTaskResponse(_ response: URLResponse?, _ error: Error?) throws {
        guard let response = response as? HTTPURLResponse else {
            guard let error = error else {
                throw RequestError.unknown
            }
            throw RequestError.someError(error)
        }
        
        guard 200...299 ~= response.statusCode else {
            throw RequestError.responseError(response.statusCode)
        }
    }
    
    private func responseObject<RESPONSE: ResponseProtocol>(_ data: Data?) throws -> RESPONSE {
        guard let data = data else {
            throw RequestError.noData
        }
        
        guard let responseObject = RESPONSE.responseObject(data) else {
            throw RequestError.decoding
        }
        
        return responseObject
    }
}
