//
//  ThemeProtocol.swift
//  Reddit_test
//
//  Created by Artem Belenkov on 15.02.2020.
//  Copyright © 2020 Artem Belenkov. All rights reserved.
//

import UIKit

protocol ThemeManagerProtocol {
    static var shared: ThemeManagerProtocol { get }
    
    var application: ApplicationThemeProtocol { get }
    var topic: TopicThemeProtocol { get }
}

struct BaseThemeManager: ThemeManagerProtocol {
    static let shared: ThemeManagerProtocol = BaseThemeManager()
    
    var topic: TopicThemeProtocol = TopicBaseTheme()
    let application: ApplicationThemeProtocol = ApplicationBaseTheme()
}
