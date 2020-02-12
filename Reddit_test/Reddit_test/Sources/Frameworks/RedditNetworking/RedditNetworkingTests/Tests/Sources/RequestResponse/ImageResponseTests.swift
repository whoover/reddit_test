//
//  ImageResponseTests.swift
//  RedditNetworkingTests
//
//  Created by Artem Belenkov on 12/02/2020.
//  Copyright © 2020 Artem Belenkov. All rights reserved.
//

import XCTest
@testable import RedditNetworking

class ImageResponseTests: XCTestCase {
    func testCorrectResponse() {
        do {
            let response = try ImageResponse.responseObject(UIImage.testImageData)
            XCTAssertNotNil(response)
        } catch {
            XCTAssert(true)
        }
    }
    
    func testIncorrectResponse() {
        do {
            _ = try ImageResponse.responseObject("".data(using: .utf8))
            XCTAssert(true)
        } catch {
            XCTAssertNotNil(error)
        }
    }
}
