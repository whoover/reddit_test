//
//  ThemeServiceLocator.swift
//  Reddit_test
//
//  Created by Artem Belenkov on 15.02.2020.
//  Copyright © 2020 Artem Belenkov. All rights reserved.
//

import UIKit

protocol ThemeServiceLocator {
    func themeService() -> ThemeManagerProtocol
}

extension ThemeServiceLocator {
    func themeService() -> ThemeManagerProtocol {
        BaseThemeManager.shared
    }
}
