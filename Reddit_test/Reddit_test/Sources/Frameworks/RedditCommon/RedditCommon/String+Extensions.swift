//
//  String+Extensions.swift
//  RedditCommon
//
//  Created by Artem Belenkov on 15.02.2020.
//  Copyright © 2020 Artem Belenkov. All rights reserved.
//

import Foundation

public extension String {
    var nsRange: NSRange {
        NSRange(self.startIndex..., in: self)
    }
}
