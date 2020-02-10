//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___
//	___COPYRIGHT___
//

import UIKit

class ___VARIABLE_flowName___CoordinatorAssembly: AssemblyProtocol {
    func build(router: CoordinatorRouterProtocol,
               routingHandler: ___VARIABLE_flowName___CoordinatorExitRoutingProtocol) -> CoordinatorProtocol {
        let coordinator = ___VARIABLE_flowName___Coordinator(router: router)
        coordinator.exitRoutingDelegate = routingHandler
        return coordinator
    }
}
