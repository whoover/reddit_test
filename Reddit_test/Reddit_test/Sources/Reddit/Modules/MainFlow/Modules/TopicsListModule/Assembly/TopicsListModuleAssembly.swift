//
//  TopicsListModuleAssembly.swift
//  Reddit_test
//
//  Created by Artem Belenkov on 13/02/2020
//  Copyright © 2020 Artem Belenkov. All rights reserved.
//

import UIKit

typealias TopicsListModule = Module<TopicsListModuleInput, TopicsListModuleOutput>

final class TopicsListModuleAssembly: AssemblyProtocol {
    typealias ServiceLocator = TestsSettingsManagerLocator & ThemeServiceLocator & TopicsListModuleInteractorLocator
    final class ServiceLocatorImp: ServiceLocator {}
    
    private let theme: ThemeManagerProtocol
    private let interactor: TopicsListModuleInteractorInput
    
    init(serviceLocator: ServiceLocator = ServiceLocatorImp()) {
        theme = serviceLocator.themeService()
        interactor = serviceLocator.interactor(isTest: serviceLocator.testsSettingsManager().isUITestsEnvironmentEnabled)
    }
    
    func build(_ moduleOutput: TopicsListModuleOutput?,
               _ routingHandler: TopicsListModuleRoutingHandlingProtocol) -> TopicsListModule {
        // View
        let view = TopicsListModuleViewController.controllerFromStoryboard(StoryBoard.topicsList.rawValue)
        view.setupTheme(theme.topic)
                
        // Router
        let router = TopicsListModuleRouter(viewController: view)
        
        // Presenter
        let presenter = TopicsListModulePresenter(interactor: interactor, router: router, view: view, moduleOutput: moduleOutput)
        
        // Dependency Setup
        view.output = presenter
        router.routingHandler = routingHandler
        
        return Module(view: view, input: presenter, output: moduleOutput)
    }
}
