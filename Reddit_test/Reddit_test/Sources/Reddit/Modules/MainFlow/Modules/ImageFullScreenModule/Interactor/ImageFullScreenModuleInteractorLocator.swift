//
//  ImageFullScreenModuleInteractorLocator.swift
//  Reddit_test
//
//  Created by Artem Belenkov on 16.02.2020.
//  Copyright © 2020 Artem Belenkov. All rights reserved.
//

import UIKit

protocol ImageFullScreenModuleInteractorLocator {
    func interactor(_ isTest: Bool) -> ImageFullScreenModuleInteractorInput
}

extension ImageFullScreenModuleInteractorLocator {
    func interactor(_ isTest: Bool) -> ImageFullScreenModuleInteractorInput {
        isTest ? FakeImageFullScreenModuleInteractor() : ImageFullScreenModuleInteractor()
    }
}
