//
//  AppAppearence.swift
//  Reddit_test
//
//  Created by Artem Belenkov on 15.02.2020.
//  Copyright © 2020 Artem Belenkov. All rights reserved.
//

import UIKit

protocol AppAppearenceProtocol {
    func setup()
}

final class AppAppearence: AppAppearenceProtocol {
    typealias ServiceLocator = ThemeServiceLocator
    final class ServiceLocatorImpl: ServiceLocator {}
    
    private let theme: ThemeManagerProtocol
    
    init(serviceLocator: ServiceLocator = ServiceLocatorImpl()) {
        theme = serviceLocator.themeService()
    }
    
    func setup() {
        UINavigationBar.appearance().backgroundColor = theme.application.navBarColor
        let title = theme.application.navBarTitle
        var attributes: [NSAttributedString.Key: Any] = [:]
        if let color = title.color {
            attributes[.foregroundColor] = color
        }
        if let font = title.font {
            attributes[.font] = font
        }
        UINavigationBar.appearance().titleTextAttributes = attributes
    }
}
