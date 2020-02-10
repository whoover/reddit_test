//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___
//  ___COPYRIGHT___
//

import Foundation

class ___VARIABLE_compositeModuleName___CompositeModuleRouter<ContainerHolder: ___VARIABLE_compositeModuleName___CompositeModuleContainersHolderProtocol>: BaseCompositeModuleRouter<ContainerHolder> {
    weak var routingHandler: ___VARIABLE_compositeModuleName___CompositeModuleRoutingHandlingProtocol?
}

extension ___VARIABLE_compositeModuleName___CompositeModuleRouter: ___VARIABLE_compositeModuleName___CompositeModuleRouterInputProtocol {
    func showSubmodule1(_ presentable: PresentableProtocol) {
        showSubmodule(presentable, containersHolder.containerForSubmodule1)
    }
    
    func showSubmodule2(_ presentable: PresentableProtocol) {
        showSubmodule(presentable, containersHolder.containerForSubmodule2)
    }
    
    func submodule1ButtonRoute() {
        routingHandler?.sumbodule1ButtonRouting()
    }
    
    func submodule2ButtonRoute() {
        routingHandler?.sumbodule2ButtonRouting()
    }
}
