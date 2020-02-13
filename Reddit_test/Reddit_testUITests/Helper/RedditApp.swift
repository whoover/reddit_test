//
//  RedditApp.swift
//  Reddit_test
//
//  Created by Artem Belenkov on 13/02/2020
//    Copyright © 2020 Artem Belenkov. All rights reserved.
//

import Foundation
import XCTest

enum TimeoutInterval: TimeInterval {
    case short = 2
    case medium = 30
    case long = 120
}

enum WaitInterval: TimeInterval {
    case short = 1
    case medium = 3
    case long = 10
}

class RedditApp: XCUIApplication {
    static var shared: RedditApp!

    static let defaultArguments: [CommandLineArgument] = [.enableUITestsEnvironment]

    @discardableResult
    static func launch(withArguments arguments: [CommandLineArgument] = RedditApp.defaultArguments) -> RedditApp {
        let app = RedditApp()
        app.launchArguments += arguments.map { $0.rawValue }
        if app.state != .notRunning {
            app.terminate()
        }
        app.launch()
        shared = app
        return app
    }

    @discardableResult
    static func launch(withExtraArguments extraArguments: [CommandLineArgument]) -> RedditApp {
        launch(withArguments: defaultArguments + extraArguments)
    }
}

extension RedditApp {
    func scrollableFrame() -> CGRect {
        var scrollableFrame = app.window().frame

        if let statusBarFrame = app.statusBar()?.frame {
            scrollableFrame.origin.y = statusBarFrame.maxY
        }
        if let navigationBarFrame = app.navigationBar()?.frame {
            scrollableFrame.origin.y = navigationBarFrame.maxY
        }
        if let keyboardFrame = app.keyboard()?.frame {
            scrollableFrame.size.height = keyboardFrame.minY - scrollableFrame.origin.y
        }

        return scrollableFrame
    }

    func window() -> XCUIElement {
        app.windows.firstMatch
    }

    func statusBar() -> XCUIElement? {
        let statusBar = app.statusBars.firstMatch
        return statusBar.exists ? statusBar : nil
    }

    func navigationBar() -> XCUIElement? {
        let navigationBar = app.navigationBars.firstMatch
        return navigationBar.exists ? navigationBar : nil
    }

    func keyboard() -> XCUIElement? {
        let keyboard = app.keyboards.firstMatch
        return keyboard.exists ? keyboard : nil
    }
	
	func toolbarDoneButton() -> XCUIElement {
		toolbarButton("Done")
	}
	
	func toolbarButton(_ name: String) -> XCUIElement {
		toolbars.buttons[name]
	}
}

extension RedditApp {
    func wait(forInterval interval: WaitInterval = .short) {
        RunLoop.current.run(until: Date(timeIntervalSinceNow: interval.rawValue))
    }

    func waitForKeyboard(timeout: TimeoutInterval = .medium, delay: WaitInterval = .short) {
        app.keyboards.element.waitUntilExists(timeout: timeout)
        wait(forInterval: delay)
    }
}
