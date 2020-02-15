//
//  CellViewModelAddapterServiceLocator.swift
//  Reddit_test
//
//  Created by Artem Belenkov on 15.02.2020.
//  Copyright © 2020 Artem Belenkov. All rights reserved.
//

import UIKit

protocol CellViewModelAddapterServiceLocator {
    func cellViewModelAddapter() -> CellViewModelAddapterServiceProtocol
}

extension CellViewModelAddapterServiceLocator {
    func cellViewModelAddapter() -> CellViewModelAddapterServiceProtocol {
        CellViewModelAddapterService()
    }
}
