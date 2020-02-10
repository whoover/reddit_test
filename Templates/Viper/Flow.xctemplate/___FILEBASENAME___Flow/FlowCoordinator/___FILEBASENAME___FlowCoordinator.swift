//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___
//	___COPYRIGHT___
//

import Foundation

class ___VARIABLE_flowName___FlowCoordinator: BaseFlowCoordinator {
    weak var exitRoutingDelegate: ___VARIABLE_flowName___FlowRoutingExitHandler?
    
    override func start(with option: DeepLinkOption?) {
        super.start(with: option)
        startSomeModule()
    }
        
    private func startSomeModule() {
//        let loginCoordinator = LoginModuleCoordinatorAssembly().build(router: router, routingHandler: self)
//        loginCoordinator.start()
//        addChild(loginCoordinator)
    }
}

extension ___VARIABLE_flowName___FlowCoordinator {

}
