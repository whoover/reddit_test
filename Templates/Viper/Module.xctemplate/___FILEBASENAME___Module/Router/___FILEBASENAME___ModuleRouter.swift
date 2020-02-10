//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___
//  ___COPYRIGHT___
//

import Foundation

class ___VARIABLE_moduleName___ModuleRouter: BaseModuleRouter {
    weak var routingHandler: ___VARIABLE_moduleName___ModuleRoutingHandlingProtocol?
}

extension ___VARIABLE_moduleName___ModuleRouter: ___VARIABLE_moduleName___ModuleRouterInputProtocol {
    func routeForSomeAction() {
        routingHandler?.performRouteForSomeAction()
    }
}
