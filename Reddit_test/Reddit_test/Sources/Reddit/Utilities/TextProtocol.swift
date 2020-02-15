//
//  TextProtocol.swift
//  Reddit_test
//
//  Created by Artem Belenkov on 15.02.2020.
//  Copyright © 2020 Artem Belenkov. All rights reserved.
//

import UIKit

protocol TextProtocol {
    static var isAttributed: Bool { get }
}

extension String: TextProtocol {
    static var isAttributed: Bool { false }
}
extension NSAttributedString: TextProtocol {
    static var isAttributed: Bool { true }
}

struct Label {
    let settings: TextSetting
    let text: TextProtocol
}
