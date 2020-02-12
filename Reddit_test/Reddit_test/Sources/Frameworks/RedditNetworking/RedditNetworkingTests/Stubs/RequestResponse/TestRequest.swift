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
    var schema = "https"
    var host = "testHost.com"
    var path = "/test"
    var parameters: [String: String?] = ["testKey": "testParameter"]
}
