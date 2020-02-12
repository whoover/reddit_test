//
//  NSObject+Name.swift
//  RedditCommon
//
//  Created by Artem Belenkov on 12.02.2020.
//  Copyright © 2020 Artem Belenkov. All rights reserved.
//

import Foundation

public extension NSObject {
    class var className: String! {
        NSStringFromClass(self).components(separatedBy: ".").last
    }
}
