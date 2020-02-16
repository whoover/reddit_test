//
//  TopicsListModuleInteractorLocator.swift
//  Reddit_test
//
//  Created by Artem Belenkov on 16.02.2020.
//  Copyright © 2020 Artem Belenkov. All rights reserved.
//

import UIKit

protocol TopicsListModuleInteractorLocator {
    func interactor(isTest: Bool) -> TopicsListModuleInteractorInput
}

extension TopicsListModuleInteractorLocator {
    func interactor(isTest: Bool) -> TopicsListModuleInteractorInput {
        isTest ? FakeTopicsListModuleInteractor() : TopicsListModuleInteractor()
    }
}
