//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___
//  ___COPYRIGHT___
//

import Foundation

// Module Input
protocol ___VARIABLE_moduleName___ModuleInput {
    
}

// Module Output
protocol ___VARIABLE_moduleName___ModuleOutput {
    
}

// View Input
protocol ___VARIABLE_moduleName___ModuleViewInput: class {
    func set(title: String)
}

// View Output
protocol ___VARIABLE_moduleName___ModuleViewOutput: class {
    func viewDidLoad()
}

// Interactor Input
protocol ___VARIABLE_moduleName___ModuleInteractorInput {
    
}

// Interactor Output
protocol ___VARIABLE_moduleName___ModuleInteractorOutput: class {
    
}

// Router
protocol ___VARIABLE_moduleName___ModuleRouterInputProtocol: AlertRoutableProtocol {
    
}

// Routing Handling
protocol ___VARIABLE_moduleName___ModuleRoutingHandlingProtocol: ModuleRoutingHandlingProtocol {
    func performRouteForSomeAction()
}

// Coordinator Routing Handling
protocol ___VARIABLE_moduleName___ModuleCoordinatorExitRoutingProtocol: FlowExitPointProtocol {
    func performRouteForSomeAction(_ coordinator: CoordinatorProtocol)
}
