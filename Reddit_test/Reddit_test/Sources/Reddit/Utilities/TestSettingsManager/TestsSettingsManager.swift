//
//  TestsSettingsManager.swift
//  Reddit_test
//
//  Created by Artem Belenkov on 13/02/2020.
//  Copyright © 2020 Artem Belenkov. All rights reserved.
//

import UIKit

protocol TestsSettingsManagerProtocol {
    var isUITestsEnvironmentEnabled: Bool { get set }
}

class TestsSettingsManager: TestsSettingsManagerProtocol {
    static let isUITestsEnvironmentEnabledKey = "isUITestsEnvironmentEnabledKey"
    private let userDefaults: UserDefaults
    
    var isUITestsEnvironmentEnabled: Bool {
        get {
            userDefaults.bool(forKey: type(of: self).isUITestsEnvironmentEnabledKey)
        }
        set {
            userDefaults.set(newValue, forKey: type(of: self).isUITestsEnvironmentEnabledKey)
        }
    }
    
    init(userDefaults: UserDefaults = .standard) {
        self.userDefaults = userDefaults
    }
}
