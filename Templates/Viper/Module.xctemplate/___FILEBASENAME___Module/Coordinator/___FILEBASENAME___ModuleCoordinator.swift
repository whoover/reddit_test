//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___
//	___COPYRIGHT___
//

protocol ___VARIABLE_moduleName___ModuleCoordinatorProtocol: CoordinatorProtocol {
    
}

class ___VARIABLE_moduleName___ModuleCoordinator: BaseCoordinator, ___VARIABLE_moduleName___ModuleCoordinatorProtocol {
    weak var exitRoutingDelegate: ___VARIABLE_moduleName___ModuleCoordinatorExitRoutingProtocol?
    
    override func start() {
        let module = ___VARIABLE_moduleName___ModuleAssembly().build(nil, self)
        let navController = UINavigationController(rootViewController: module.toPresent())
        router.showScreen(navController)
    }
}

extension ___VARIABLE_moduleName___ModuleCoordinator: ___VARIABLE_moduleName___ModuleRoutingHandlingProtocol {
    func performRouteForSomeAction() {
        
    }
}
