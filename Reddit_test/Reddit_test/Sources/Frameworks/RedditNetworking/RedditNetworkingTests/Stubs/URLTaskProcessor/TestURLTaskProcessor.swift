//
//  TestURLTaskProcessor.swift
//  RedditNetworkingTests
//
//  Created by Artem Belenkov on 12/02/2020.
//  Copyright © 2020 Artem Belenkov. All rights reserved.
//

import Foundation
@testable import RedditCommon
@testable import RedditNetworking

class TestURLTaskProcessor: URLTaskProcessorProtocol {
    var errorToReturn: Error?
    var dataForResponse: Data?
    
    func createTask<RESPONSE>(url: URL,
                              identifier: String,
                              successBlock: BlockObject<RESPONSE, Void>,
                              errorBlock: BlockObject<Error, Void>,
                              cancelBlock: EmptyBlock) -> DataTaskProtocol where RESPONSE: ResponseProtocol {
        if let error = errorToReturn {
            errorBlock.execute(error)
        }
        if let data = dataForResponse {
            do {
                let response = try RESPONSE.responseObject(data)
                successBlock.execute(response)
            } catch {
                errorBlock.execute(error)
            }
        }
        return TestDataTask(identifier: identifier)
    }
}
