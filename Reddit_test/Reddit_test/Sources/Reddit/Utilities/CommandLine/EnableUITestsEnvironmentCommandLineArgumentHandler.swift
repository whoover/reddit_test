//
//  EnableUITestsEnvironmentCommandLineArgumentHandler.swift
//  Reddit_test
//
//  Created by Artem Belenkov on 13/02/2020
//    Copyright © 2020 Artem Belenkov. All rights reserved.
//

import UIKit

final class EnableUITestsEnvironmentCommandLineArgumentHandler: CommandLineArgumentsHandler {
    typealias ServiceLocator = TestsSettingsManagerLocator
    final class ServiceLocatorImpl: ServiceLocator {}
    
    private var testsSettingManager: TestsSettingsManagerProtocol
  
    init(serviceLocator: ServiceLocator = ServiceLocatorImpl()) {
        self.testsSettingManager = serviceLocator.testsSettingsManager()
    }
  
    func handle(arguments: [String]) {
        testsSettingManager.isUITestsEnvironmentEnabled =
            arguments.contains(CommandLineArgument.enableUITestsEnvironment.rawValue)
    }
}
