//
//  CancellableProtocol.swift
//  Reddit_test
//
//  Created by Artem Belenkov on 10.02.2020.
//  Copyright © 2020 Artem Belenkov. All rights reserved.
//

import UIKit

protocol CancellableProtocol {
    func cancel()
}

extension URLSessionDataTask: CancellableProtocol {}
