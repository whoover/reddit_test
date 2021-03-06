//
//  XCUIElementQuery.swift
//  Reddit_test
//
//  Created by Artem Belenkov on 13/02/2020
//    Copyright © 2020 Artem Belenkov. All rights reserved.
//

import Foundation
import XCTest

extension XCUIElementQuery {
    func element(caseInsensitive key: String) -> XCUIElement {
        let predicate = NSPredicate(format: "label CONTAINS[c] %@", key)
        return element(matching: predicate)
    }
}
