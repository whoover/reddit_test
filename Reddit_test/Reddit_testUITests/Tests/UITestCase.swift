//
//  UITestCase.swift
//  Reddit_testUITests
//
//  Created by Artem Belenkov on 13/02/2020.
//  Copyright © 2020 Artem Belenkov. All rights reserved.
//

import XCTest

class UITestCase: XCTestCase {
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        RedditApp.launch()
        RedditApp.shared.wait(forInterval:.medium)
    }
}
