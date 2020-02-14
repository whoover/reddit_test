//
//  Theme.swift
//  Reddit_test
//
//  Created by Artem Belenkov on 12.02.2020.
//  Copyright © 2020 Artem Belenkov. All rights reserved.
//

import RedditCommonUI
import UIKit

struct Theme {
    private static let lightThemeColors: [Color: String] = [
        .red: "#ff0000",
        .orange: "#ff0000",
        .gray: "#ff0000",
        .black: "#000000"
    ]
    
    private static let darkThemeColors: [Color: String] = [
        .red: "#ff0000",
        .orange: "#ff0000",
        .gray: "#ff0000",
        .black: "#ffffff"
    ]
    
    enum Color: String {
        case black
        case darkGray
        case lightGray
        case white
        case gray
        case red
        case green
        case blue
        case cyan
        case yellow
        case magenta
        case orange
        case purple
        case brown
    }

    static func color(_ type: Color) -> UIColor {
        var isDarkMode = false
        if #available(iOS 13.0, *) { isDarkMode = UITraitCollection.current.userInterfaceStyle == .dark }
        let colorCollection = isDarkMode ? darkThemeColors : lightThemeColors
        guard let hexColor = colorCollection[type] else {
            fatalError("not found color with type: \(type.rawValue)")
        }
        return UIColor(hex: hexColor)
    }
    
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
}
