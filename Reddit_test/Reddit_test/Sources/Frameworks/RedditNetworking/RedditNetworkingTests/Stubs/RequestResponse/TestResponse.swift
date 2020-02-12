//
//  TestResponse.swift
//  RedditNetworkingTests
//
//  Created by Artem Belenkov on 12/02/2020.
//  Copyright © 2020 Artem Belenkov. All rights reserved.
//

import UIKit
@testable import RedditNetworking

struct TestResponse: ResponseProtocol {
    let string: String
    
    static func responseObject(_ data: Data?) throws -> TestResponse {
        guard let data = data,
            let string = String(data: data, encoding: .utf8) else {
            throw TestError.someError
        }
        return TestResponse(string: string)
    }
}
