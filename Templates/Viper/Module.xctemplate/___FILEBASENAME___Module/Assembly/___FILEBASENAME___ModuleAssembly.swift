//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___
//  ___COPYRIGHT___
//

import UIKit

typealias ___VARIABLE_moduleName___Module = Module<___VARIABLE_moduleName___ModuleInput, ___VARIABLE_moduleName___ModuleOutput>

class ___VARIABLE_moduleName___ModuleAssembly: AssemblyProtocol {
    func build(_ moduleOutput: ___VARIABLE_moduleName___ModuleOutput?,
               _ routingHandler: ___VARIABLE_moduleName___ModuleRoutingHandlingProtocol) -> ___VARIABLE_moduleName___Module {
        // View
        let view = ___VARIABLE_moduleName___ModuleViewController()
        
        // Interactor
        let interactor = ___VARIABLE_moduleName___ModuleInteractor()
        
        // Router
        let router = ___VARIABLE_moduleName___ModuleRouter(viewController: view)
        
        // Presenter
        let presenter = ___VARIABLE_moduleName___ModulePresenter(interactor: interactor, router: router, view: view, moduleOutput: moduleOutput)
        
        // Dependency Setup
        view.output = presenter
        interactor.output = presenter
        router.routingHandler = routingHandler
        
        return Module(view: view, input: presenter, output: moduleOutput)
    }
}
