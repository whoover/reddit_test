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
    var app: RedditApp { return RedditApp.shared }

    func table() -> XCUIElement {
        return app.tables.element(boundBy: 0)
    }
	
    func alertButton(_ button: String) -> XCUIElement {
        return app.alerts.buttons[button]
    }

    func navigationBar(titled title: String) -> XCUIElement {
        return app.navigationBars[title]
    }
    
    func cell(named name: String) -> XCUIElement {
        return table().staticTexts[name]
    }
}
