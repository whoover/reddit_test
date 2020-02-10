//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___
//  ___COPYRIGHT___
//

import UIKit

class ___VARIABLE_compositeModuleName___CompositeModuleViewController: BaseViewController {
    var output: ___VARIABLE_compositeModuleName___CompositeModuleViewOutput?
    
    private let container1 = UIView()
    private let container2 = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubviews()
        output?.viewDidLoad()
    }
}

// MARK: - Configure
extension ___VARIABLE_compositeModuleName___CompositeModuleViewController: ___VARIABLE_compositeModuleName___CompositeModuleViewInput {
    private func setupSubviews() {
        
    }
}

// MARK: View Input
extension ___VARIABLE_compositeModuleName___CompositeModuleViewController {
    func set(title: String) {
        self.title = title
    }
}

// MARK: Button Action
extension ___VARIABLE_compositeModuleName___CompositeModuleViewController {
    
}

extension ___VARIABLE_compositeModuleName___CompositeModuleViewController: ___VARIABLE_compositeModuleName___CompositeModuleContainersHolderProtocol {
    var containerForSubmodule1: UIView {
        return container1
    }
    
    var containerForSubmodule2: UIView {
        return container2
    }
}
