//
//  AddapterServiceLocator.swift
//  Reddit_test
//
//  Created by Artem Belenkov on 12.02.2020.
//  Copyright © 2020 Artem Belenkov. All rights reserved.
//

import UIKit

protocol AddapterServiceLocator {
    func addapter() -> AddapterServiceProtocol 
}

extension AddapterServiceLocator {
    func addapter() -> AddapterServiceProtocol {
        AddapterService()
    }
}
