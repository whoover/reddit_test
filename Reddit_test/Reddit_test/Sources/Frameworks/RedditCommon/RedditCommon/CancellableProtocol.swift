//
//  CancellableProtocol.swift
//  Reddit_test
//
//  Created by Artem Belenkov on 10.02.2020.
//  Copyright © 2020 Artem Belenkov. All rights reserved.
//

import UIKit

public protocol CancellableProtocol {
    var isCanceled: Bool { get }
    var identifier: String { get }
    
    func cancel()
}
