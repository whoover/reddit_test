//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___
//  ___COPYRIGHT___
//

import UIKit

typealias ___VARIABLE_compositeModuleName___CompositeModule = Module<___VARIABLE_compositeModuleName___CompositeModuleInput, ___VARIABLE_compositeModuleName___CompositeModuleOutput>

class ___VARIABLE_compositeModuleName___CompositeModuleAssembly: AssemblyProtocol {
    required init() { }
    
    func build(_ moduleOutput: ___VARIABLE_compositeModuleName___CompositeModuleOutput?, _ routingHandler: ___VARIABLE_compositeModuleName___CompositeModuleRoutingHandlingProtocol) -> ___VARIABLE_compositeModuleName___CompositeModule {
        // View
        let view = ___VARIABLE_compositeModuleName___CompositeModuleViewController()
        
        // Interactor
        let interactor = ___VARIABLE_compositeModuleName___CompositeModuleInteractor()
        
        // Router
        let router = ___VARIABLE_compositeModuleName___CompositeModuleRouter(viewController: view, containersHolder: view)
        
        // Presenter
        let presenter = ___VARIABLE_compositeModuleName___CompositeModulePresenter(interactor: interactor, router: router, view: view, moduleOutput: moduleOutput)
        
        // Submodules
//        let submodule1 = Submodule1ModuleAssembly().build(presenter, presenter)
//
//        let submodule2 = Submodule2ModuleAssembly().build(presenter, presenter)
//
//        presenter.submodule1 = submodule1
//        presenter.storyInfoSubmodule = submodule2
        
        // Dependency Setup
        view.output = presenter
        interactor.output = presenter
        router.routingHandler = routingHandler
        
        return Module(view: view, input: presenter, output: moduleOutput)
    }
}
