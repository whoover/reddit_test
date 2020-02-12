//
//  ResponseProtocol.swift
//  Reddit_test
//
//  Created by Artem Belenkov on 11.02.2020.
//  Copyright © 2020 Artem Belenkov. All rights reserved.
//

import Foundation

public protocol ResponseProtocol {
    static func responseObject(_ data: Data?) throws -> Self
}
