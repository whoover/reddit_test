//
//  Font.swift
//  Reddit_test
//
//  Created by Artem Belenkov on 15.02.2020.
//  Copyright © 2020 Artem Belenkov. All rights reserved.
//

import UIKit

enum Font {
    case light
    case regular
    case medium
    case bold
    
    enum Size: CGFloat {
        case xxlarge = 30
        case xlarge = 25
        case large = 20
        case medium = 18
        case normal = 16
        case small = 12
        case xsmall = 10
    }
    
    func font(size: Size) -> UIFont? {
        let fontSize = size.rawValue
        var fontWight: UIFont.Weight
        switch self {
        case .medium:
            fontWight = .medium
        case .light:
            fontWight = .light
        case .regular:
            fontWight = .regular
        case .bold:
            fontWight = .bold
        }
        return UIFont.systemFont(ofSize: fontSize, weight: fontWight)
    }
}
