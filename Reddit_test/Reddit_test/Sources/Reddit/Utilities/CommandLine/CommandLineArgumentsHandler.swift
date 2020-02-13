//
//  CommandLineArgumentsHandler.swift
//  Reddit_test
//
//  Created by Artem Belenkov on 13/02/2020
//    Copyright © 2020 Artem Belenkov. All rights reserved.
//

import UIKit

protocol CommandLineArgumentsHandler {
    func handle(arguments: [String])
}

@objc class CommandLineLaunchHandler: NSObject {
    private let handlers: [CommandLineArgumentsHandler] = [
        EnableUITestsEnvironmentCommandLineArgumentHandler()
    ]
  
    @objc func handleLaunch() {
        handlers.forEach { $0.handle(arguments: CommandLine.arguments) }
    }
  
    static func launched(with argument: CommandLineArgument) -> Bool {
        return CommandLine.arguments.contains(argument.rawValue)
    }
}
