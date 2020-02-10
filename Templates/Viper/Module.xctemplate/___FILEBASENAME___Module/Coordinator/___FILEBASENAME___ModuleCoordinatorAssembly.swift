//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___
//	___COPYRIGHT___
//

import UIKit

class ___VARIABLE_moduleName___ModuleCoordinatorAssembly: AssemblyProtocol {
    func build(router: CoordinatorRouterProtocol,
               routingHandler: ___VARIABLE_moduleName___ModuleCoordinatorExitRoutingProtocol) -> CoordinatorProtocol {
        let coordinator = ___VARIABLE_moduleName___ModuleCoordinator(router: router)
        coordinator.exitRoutingDelegate = routingHandler
        return coordinator
    }
}
