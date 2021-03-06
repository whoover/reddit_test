//
//  ApplicationThemeProtocol.swift
//  Reddit_test
//
//  Created by Artem Belenkov on 15.02.2020.
//  Copyright © 2020 Artem Belenkov. All rights reserved.
//

import UIKit

protocol ApplicationThemeProtocol {
    var navBarColor: UIColor { get }
    var navBarTitle: TextSetting { get }
}
