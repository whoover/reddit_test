//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___
//  ___COPYRIGHT___
//

import UIKit

// Module Input
protocol ___VARIABLE_compositeModuleName___CompositeModuleInput {
    
}

// Module Output
protocol ___VARIABLE_compositeModuleName___CompositeModuleOutput {
    
}

// View Input
protocol ___VARIABLE_compositeModuleName___CompositeModuleViewInput: class {
    func set(title: String)
}

// View Output
protocol ___VARIABLE_compositeModuleName___CompositeModuleViewOutput: class {
    func viewDidLoad()
}

// View Composite Module Containers Holder
protocol ___VARIABLE_compositeModuleName___CompositeModuleContainersHolderProtocol: ContainersHolderProtocol {
    var containerForSubmodule1: UIView { get }
    var containerForSubmodule2: UIView { get }
}

// Interactor Input
protocol ___VARIABLE_compositeModuleName___CompositeModuleInteractorInput {
    
}

// Interactor Output
protocol ___VARIABLE_compositeModuleName___CompositeModuleInteractorOutput: class {
    
}

// Router
protocol ___VARIABLE_compositeModuleName___CompositeModuleRouterInputProtocol: AlertRoutableProtocol {
    func showSubmodule1(_ presentable: PresentableProtocol)
    func showSubmodule2(_ presentable: PresentableProtocol)
    
    func submodule1ButtonRoute()
    func submodule2ButtonRoute()
}

// Routing Handling
protocol ___VARIABLE_compositeModuleName___CompositeModuleRoutingHandlingProtocol: ModuleRoutingHandlingProtocol {
    func sumbodule1ButtonRouting()
    func sumbodule2ButtonRouting()
}

// Coordinator Routing Handling
protocol ___VARIABLE_compositeModuleName___CompositeModuleCoordinatorExitRoutingProtocol: FlowExitPointProtocol {
    func performRouteForSomeAction(_ coordinator: CoordinatorProtocol)
}
