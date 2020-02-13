//
//  RunLoop+Testing.swift
//  Reddit_test
//
//  Created by Artem Belenkov on 13/02/2020
//    Copyright © 2020 Artem Belenkov. All rights reserved.
//

import XCTest

extension RunLoop {
    class func wait(_ time: TimeInterval = 5.0, _ condition: () -> Bool) {
        var shouldWait = true
        let runLoop = RunLoop.current
        var currentDate = Date()
        let finishDate = currentDate.addingTimeInterval(time)
        while shouldWait && finishDate.timeIntervalSince1970 > currentDate.timeIntervalSince1970 {
            runLoop.run(mode: .default, before: currentDate + 1.0)
            shouldWait = condition()
            currentDate = Date()
        }
    }
  
    class func waitForElement(element: XCUIElement, time: TimeInterval = 5.0) -> XCUIElement? {
        wait(time) { () -> Bool in
            !element.exists
        }
        return element.exists ? element : nil
    }
}
