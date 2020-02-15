//
//  ApplicationBaseTheme.swift
//  Reddit_test
//
//  Created by Artem Belenkov on 15.02.2020.
//  Copyright © 2020 Artem Belenkov. All rights reserved.
//

import UIKit

class ApplicationBaseTheme: ApplicationThemeProtocol {
    let navBarColor: UIColor = .white
    let navBarTitle: TextSetting = TextSetting(color: .black,
                                               font: Font.bold.font(size: .large))
}
