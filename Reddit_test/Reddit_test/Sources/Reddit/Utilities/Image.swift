//
//  Image.swift
//  Reddit_test
//
//  Created by Artem Belenkov on 16.02.2020.
//  Copyright © 2020 Artem Belenkov. All rights reserved.
//

import UIKit

struct Image {
    struct Topic {
        static let fullScreenImage = UIImage(named: "fullscreen")?.withTintColor(.gray)
        static let defaultImage = UIImage(named: "image_stub")
        
        static func arrows(color: UIColor) -> UIImage? {
            UIImage(named: "arrows")?.withTintColor(color)
        }
        
        static func commets(color: UIColor) -> UIImage? {
            UIImage(named: "comments")?.withTintColor(color)
        }
    }
    
    struct ImageFullScreen {
        static let save = UIImage(named: "save")?.withTintColor(.white)
    }
}
