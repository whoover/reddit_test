//
//  TopicsListPage.swift
//  Reddit_testUITests
//
//  Created by Artem Belenkov on 13/02/2020.
//  Copyright © 2020 Artem Belenkov. All rights reserved.
//

import Foundation
import XCTest

class TopicsListPage: UITestingPage {
    func imageWithAtIndex(_ index: Int) -> XCUIElement {
        app.images["Some fake title \(index) image"]
    }
}

extension TopicsListPage {
    func openFullScreenImage(_ index: Int, _ completion: (_ imagePage: ImagePage) -> Void) {
        imageWithAtIndex(index).tap()
        completion(ImagePage())
    }
}
