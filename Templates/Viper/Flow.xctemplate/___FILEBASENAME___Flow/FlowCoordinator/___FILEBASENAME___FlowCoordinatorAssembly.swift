//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___
//	___COPYRIGHT___
//

import UIKit

class ___VARIABLE_flowName___FlowCoordinatorAssembly: AssemblyProtocol {
    required init() {}
    
    func build(_ coordinatorRoutingHandler: ___VARIABLE_flowName___FlowRoutingExitHandler) -> BaseFlowCoordinator {
        let router = CoordinatorRouter()
        let coordinator = ___VARIABLE_flowName___FlowCoordinator(router: router)
        coordinator.exitRoutingDelegate = coordinatorRoutingHandler
        return coordinator
    }
}
