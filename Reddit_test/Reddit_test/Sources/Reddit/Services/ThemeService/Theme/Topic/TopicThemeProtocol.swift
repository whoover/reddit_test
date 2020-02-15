//
//  TopicThemeProtocol.swift
//  Reddit_test
//
//  Created by Artem Belenkov on 15.02.2020.
//  Copyright © 2020 Artem Belenkov. All rights reserved.
//

import UIKit

protocol TopicThemeProtocol {
    var backgroundColor: UIColor { get }
    var cellBackground: UIColor { get }
    var topLabelText: TextSetting { get }
    var text: TextSetting { get }
    var bottomLabelImageColor: UIColor { get }
    var bottomLabelText: TextSetting { get }
    var separatorColor: UIColor { get }
}
