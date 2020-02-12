//
//  TestHTTPURLResponse.swift
//  RedditNetworkingTests
//
//  Created by Artem Belenkov on 12/02/2020.
//  Copyright © 2020 Artem Belenkov. All rights reserved.
//

import UIKit

extension HTTPURLResponse {
    static func testResponse(code: Int) -> HTTPURLResponse! {
        HTTPURLResponse(url: URL.testURL,
                        statusCode: code,
                        httpVersion: nil,
                        headerFields: nil)
    }
}
