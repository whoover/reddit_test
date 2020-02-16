//
//  ImagePage.swift
//  Reddit_testUITests
//
//  Created by Artem Belenkov on 13/02/2020.
//  Copyright © 2020 Artem Belenkov. All rights reserved.
//

import Foundation
import XCTest

class ImagePage: UITestingPage {
    func saveButton() -> XCUIElement {
        app.buttons["saveButton"]
    }
    
    func closeButton() -> XCUIElement {
       app.buttons["closeButton"]
    }
}

extension ImagePage {
    func close() {
        closeButton().tap()
    }
}
