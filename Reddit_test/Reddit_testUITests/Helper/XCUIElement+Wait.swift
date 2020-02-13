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
    @discardableResult
    func wait(timeout: TimeoutInterval = .short, expectation: ((XCUIElement) -> XCTestExpectation)) -> XCTWaiter.Result {
        XCTWaiter().wait(for: [expectation(self)], timeout: timeout.rawValue)
    }

    @discardableResult
    func waitUntil(key: String, timeout: TimeoutInterval = .short, failOnNotCompleted: Bool = true, file: StaticString = #file, line: UInt = #line) -> XCUIElement? {
        let result = wait(timeout: timeout) { element in
            let predicate = NSPredicate(format: "\(key) == true")
            return XCTNSPredicateExpectation(predicate: predicate, object: element)
        }

        if failOnNotCompleted && result != .completed {
            XCTFail(file: file, line: line)
            return nil
        }

        return result == .completed ? self : nil
    }

    @discardableResult
    func waitUntilExists(timeout: TimeoutInterval = .short, failOnNotCompleted: Bool = true, file: StaticString = #file, line: UInt = #line) -> XCUIElement? {
        waitUntil(key: "exists", timeout: timeout, failOnNotCompleted: failOnNotCompleted, file: file, line: line)
    }

    @discardableResult
    func waitUntilIsInScrollableArea(timeout: TimeoutInterval = .short, failOnNotCompleted: Bool = true, file: StaticString = #file, line: UInt = #line) -> XCUIElement? {
        waitUntil(key: "isInScrollableArea", timeout: timeout, failOnNotCompleted: failOnNotCompleted, file: file, line: line)
    }
}
