//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___
//	___COPYRIGHT___
//

import UIKit

class ___VARIABLE_compositeModuleName___CompositeModuleCoordinatorAssembly: AssemblyProtocol {
    func build(router: CoordinatorRouterProtocol,
               routingHandler: ___VARIABLE_compositeModuleName___CompositeModuleCoordinatorExitRoutingProtocol) -> CoordinatorProtocol {
        let coordinator = ___VARIABLE_compositeModuleName___CompositeModuleCoordinator(router: router)
        coordinator.exitRoutingDelegate = routingHandler
        return coordinator
    }
}
