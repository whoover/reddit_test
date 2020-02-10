//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___
//  ___COPYRIGHT___
//

import UIKit

class ___VARIABLE_moduleName___ModuleViewController: BaseViewController {
    var output: ___VARIABLE_moduleName___ModuleViewOutput?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubviews()
        output?.viewDidLoad()
    }
}

// MARK: - Configure
extension ___VARIABLE_moduleName___ModuleViewController: ___VARIABLE_moduleName___ModuleViewInput {
    private func setupSubviews() {
        
    }
}

// MARK: View Input
extension ___VARIABLE_moduleName___ModuleViewController {
    func set(title: String) {
        self.title = title
    }
}

// MARK: Button Action
extension ___VARIABLE_moduleName___ModuleViewController {
    
}
