//
//  BlockObject.swift
//  Reddit_test
//
//  Created by Artem Belenkov on 11.02.2020.
//  Copyright © 2020 Artem Belenkov. All rights reserved.
//

import Foundation

public struct BlockObject<T: Any, R: Any> {
    public let execute: ((T) -> R)
    
    public init(_ execute: @escaping ((T) -> R)) {
        self.execute = execute
    }
}

typealias EmptyBlock = BlockObject<(), Void>
