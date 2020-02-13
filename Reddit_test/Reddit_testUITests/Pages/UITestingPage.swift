//
//  UITestingPage.swift
//  Reddit_test
//
//  Created by Artem Belenkov on 13/02/2020
//  Copyright © 2020 Artem Belenkov. All rights reserved.
//

import Foundation
import XCTest

class UITestingPage {
    var app: RedditApp { RedditApp.shared }

    func table() -> XCUIElement {
        app.tables.element(boundBy: 0)
    }
	
    func alertButton(_ button: String) -> XCUIElement {
        app.alerts.buttons[button]
    }

    func navigationBar(titled title: String) -> XCUIElement {
        app.navigationBars[title]
    }
    
    func cell(named name: String) -> XCUIElement {
        table().staticTexts[name]
    }
}
