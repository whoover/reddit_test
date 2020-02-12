//
//  RequestStub.swift
//  RedditNetworkingTests
//
//  Created by Artem Belenkov on 12/02/2020.
//  Copyright © 2020 Artem Belenkov. All rights reserved.
//

import UIKit
@testable import RedditNetworking

struct TestRequest: RequestProtocol {
    let schema = "testSchema"
    let host = "testHost"
    let path = "test/path"
    let parameters: [String: String?] = ["testKey": "testParameter"]
}
