//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___
//	___COPYRIGHT___
//

protocol ___VARIABLE_flowName___CoordinatorProtocol: CoordinatorProtocol {
    
}

class ___VARIABLE_flowName___Coordinator: BaseCoordinator, ___VARIABLE_flowName___CoordinatorProtocol {
    weak var exitRoutingDelegate: ___VARIABLE_flowName___CoordinatorExitRoutingProtocol?
    
    override func start() {
        let module = ___VARIABLE_flowName___Assembly().build(nil, self)
        let navController = UINavigationController(rootViewController: module.toPresent())
        router.showScreen(navController)
    }
}

extension ___VARIABLE_flowName___Coordinator: ___VARIABLE_flowName___RoutingHandlingProtocol {

}
