//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___
//	___COPYRIGHT___
//

protocol ___VARIABLE_compositeModuleName___CompositeModuleCoordinatorProtocol: CoordinatorProtocol {
    
}

class ___VARIABLE_compositeModuleName___CompositeModuleCoordinator: BaseCoordinator, ___VARIABLE_compositeModuleName___CompositeModuleCoordinatorProtocol {
    weak var exitRoutingDelegate: ___VARIABLE_compositeModuleName___CompositeModuleCoordinatorExitRoutingProtocol?
    
    override func start() {
        let module = ___VARIABLE_compositeModuleName___CompositeModuleAssembly().build(nil, self)
        let navController = UINavigationController(rootViewController: module.toPresent())
        router.showScreen(navController)
    }
}

extension ___VARIABLE_compositeModuleName___CompositeModuleCoordinator: ___VARIABLE_compositeModuleName___CompositeModuleRoutingHandlingProtocol {
    func sumbodule1ButtonRouting() {

    }

    func sumbodule2ButtonRouting() {

    }

    func performRouteForSomeAction() {

    }
}
