//
//  UIColor+Extensions.swift
//  RedditCommonUI
//
//  Created by Artem Belenkov on 15.02.2020.
//  Copyright © 2020 Artem Belenkov. All rights reserved.
//

import UIKit

public extension UIColor {
    static func color(r: Int, b: Int, g: Int) -> UIColor {
        UIColor(red: CGFloat(r) / 255.0, green: CGFloat(b) / 255.0, blue: CGFloat(g) / 255.0, alpha: 1.0)
    }
}
