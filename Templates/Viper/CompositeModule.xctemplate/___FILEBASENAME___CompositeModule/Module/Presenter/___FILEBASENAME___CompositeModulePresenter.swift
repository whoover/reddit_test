//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___
//  ___COPYRIGHT___
//

import Foundation

class ___VARIABLE_compositeModuleName___CompositeModulePresenter: BasePresenter
<___VARIABLE_compositeModuleName___CompositeModuleOutput,
___VARIABLE_compositeModuleName___CompositeModuleInteractorInput,
___VARIABLE_compositeModuleName___CompositeModuleRouterInputProtocol,
___VARIABLE_compositeModuleName___CompositeModuleViewInput> {
//    var submodule1: Module<Submodule1ModuleInput, Submodule1ModuleOutput>?
//    var submodule2: Module<Submodule2ModuleInput, Submodule2ModuleOutput>?
}

// MARK: Private
extension ___VARIABLE_compositeModuleName___CompositeModulePresenter {
    private func setupSubmodules() {
//        guard let submodule1 = submodule1,
//            let submodule2 = submodule2 else {
//                return
//        }
//        router.showSubmodule1(submodule1)
//        router.showSubmodule2(submodule2)
    }
}

// MARK: Module Input
extension ___VARIABLE_compositeModuleName___CompositeModulePresenter: ___VARIABLE_compositeModuleName___CompositeModuleInput {

}

// MARK: View Output
extension ___VARIABLE_compositeModuleName___CompositeModulePresenter: ___VARIABLE_compositeModuleName___CompositeModuleViewOutput {
    func viewDidLoad() {
        view?.set(title: "___VARIABLE_compositeModuleName___Module")
        setupSubmodules()
    }
}

// MARK: Interactor Output
extension ___VARIABLE_compositeModuleName___CompositeModulePresenter: ___VARIABLE_compositeModuleName___CompositeModuleInteractorOutput {
    
}

// MARK: Interactor Output
extension ___VARIABLE_compositeModuleName___CompositeModulePresenter: StoryCompositeModuleInteractorOutput {
    
}

// MARK: Sumbmodules Outputs
//extension ___VARIABLE_compositeModuleName___CompositeModulePresenter: Submodule1ModuleOutput {
//    
//}
//
//extension ___VARIABLE_compositeModuleName___CompositeModulePresenter: Submodule2ModuleOutput {
//    
//}

// MARK: Submodules Routing Handling
//extension ___VARIABLE_compositeModuleName___CompositeModulePresenter: Submodule1RoutingHandler {
//    func tapSubmodule1ModuleButton() {
//        router.submodule1ButtonRoute()
//    }
//}
//
//extension ___VARIABLE_compositeModuleName___CompositeModulePresenter: Submodule2RoutingHandler {
//    func tapSubmodule2ModuleButton() {
//        router.submodule2ButtonRoute()
//    }
//}
