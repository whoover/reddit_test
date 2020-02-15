//
//  TopicBaseTheme.swift
//  Reddit_test
//
//  Created by Artem Belenkov on 15.02.2020.
//  Copyright © 2020 Artem Belenkov. All rights reserved.
//

import UIKit
import RedditCommonUI

struct TopicBaseTheme: TopicThemeProtocol {
    let backgroundColor: UIColor = UIColor.color(r: 219, b: 224, g: 229)
    
    let cellBackground: UIColor = .white
    
    let topLabelText: TextSetting = TextSetting(color: UIColor.color(r: 151, b: 154, g: 156), font: Font.regular.font(size: .small))
        
    let text: TextSetting = TextSetting(color: .black, font: Font.regular.font(size: .large))
    
    let bottomLabelImageColor: UIColor = UIColor.color(r: 136, b: 138, g: 140)
    
    let bottomLabelText: TextSetting = TextSetting(color: UIColor.color(r: 136, b: 138, g: 140), font: Font.bold.font(size: .small))
    
    let separatorColor: UIColor = .lightGray
}
