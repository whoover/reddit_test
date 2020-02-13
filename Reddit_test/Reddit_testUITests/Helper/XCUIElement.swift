//
//  XCUIElement.swift
//  Reddit_test
//
//  Created by Artem Belenkov on 13/02/2020
//    Copyright © 2020 Artem Belenkov. All rights reserved.
//

import CoreGraphics
import Foundation
import XCTest

extension XCUIElement {
    var app: RedditApp { return RedditApp.shared }

    @objc var isInScrollableArea: Bool {
        !frame.isEmpty && app.scrollableFrame().contains(frame.center)
    }
	
	@discardableResult
	func smartTypeText(_ text: String, hideKeyboard: Bool = true) -> XCUIElement {
		smartTap()
		app.waitForKeyboard()
		
		guard let stringValue = self.value as? String else {
			return self
		}
		
		var deleteString = String()
		for _ in stringValue {
			deleteString += XCUIKeyboardKey.delete.rawValue
		}
		typeText(deleteString)
		
		typeText(text)
				
		return self
	}

    @discardableResult
    func smartTap(wait waitOnStart: Bool = true) -> XCUIElement {
        if waitOnStart {
            app.wait()
        }

        if isHittable {
            tap()
        } else {
            coordinate(withNormalizedOffset: CGVector(dx: 0, dy: 0)).tap()
        }

        return self
    }
}
