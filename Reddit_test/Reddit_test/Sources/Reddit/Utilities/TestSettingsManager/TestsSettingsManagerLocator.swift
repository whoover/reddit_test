//
//  TestsSettingsManagerLocator.swift
//  Reddit_test
//
//  Created by Artem Belenkov on 13/02/2020.
//  Copyright © 2020 Artem Belenkov. All rights reserved.
//

import UIKit

protocol TestsSettingsManagerLocator {
    func testsSettingsManager() -> TestsSettingsManagerProtocol
}

extension TestsSettingsManagerLocator {
    func testsSettingsManager() -> TestsSettingsManagerProtocol {
        TestsSettingsManager()
    }
}
