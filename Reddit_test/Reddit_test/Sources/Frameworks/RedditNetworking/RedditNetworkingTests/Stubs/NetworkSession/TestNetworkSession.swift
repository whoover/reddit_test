//
//  TestNetworkSession.swift
//  RedditNetworkingTests
//
//  Created by Artem Belenkov on 12/02/2020.
//  Copyright © 2020 Artem Belenkov. All rights reserved.
//

import UIKit
@testable import RedditNetworking

class TestNetworkSession: NetworkSessionProtocol {
    var dataToReturn: Data?
    var responseToReturn: URLResponse?
    var errorToReturn: Error?
    func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        completionHandler(dataToReturn, responseToReturn, errorToReturn)
        return URLSession(configuration: URLSessionConfiguration.default).dataTask(with: url)
    }
}
