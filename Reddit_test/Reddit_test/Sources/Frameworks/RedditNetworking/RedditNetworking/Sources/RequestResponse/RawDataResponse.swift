//
//  RawDataResponse.swift
//  RedditNetworking
//
//  Created by Artem Belenkov on 12.02.2020.
//  Copyright © 2020 Artem Belenkov. All rights reserved.
//

import Foundation

public enum DataError: Error {
    case noData
}

public struct DataResponse: ResponseProtocol {
    public var httpResponse: HTTPURLResponse
    public let data: Data
    
    public static func responseObject(_ data: Data?, _ response: HTTPURLResponse) throws -> DataResponse {
        guard let data = data else {
            throw DataError.noData
        }
        
        return DataResponse(httpResponse: response, data: data)
    }
}
