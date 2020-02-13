//
//  TopicsListModulePresenter.swift
//  Reddit_test
//
//  Created by Artem Belenkov on 13/02/2020
//  Copyright © 2020 Artem Belenkov. All rights reserved.
//

import Foundation

class TopicsListModulePresenter: BasePresenter
<TopicsListModuleOutput,
TopicsListModuleInteractorInput,
TopicsListModuleRouterInputProtocol,
TopicsListModuleViewInput> {
}

// MARK: Private
extension TopicsListModulePresenter {
    
}

// MARK: Module Input
extension TopicsListModulePresenter: TopicsListModuleInput {
    
}

// MARK: View Output
extension TopicsListModulePresenter: TopicsListModuleViewOutput {
    func viewDidLoad() {
        view?.set(title: "TopicsListModule")
    }
}

// MARK: Interactor Output
extension TopicsListModulePresenter: TopicsListModuleInteractorOutput {
    
}
