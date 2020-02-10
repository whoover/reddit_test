//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___
//	___COPYRIGHT___
//

import Foundation

protocol ___FILEBASENAME___ {
    func service___VARIABLE_serviceName___() -> ___VARIABLE_serviceName___ServiceProtocol
}

extension ___FILEBASENAME___ {
    func service___VARIABLE_serviceName___() -> ___VARIABLE_serviceName___ServiceProtocol {
        return ___VARIABLE_serviceName___Service()
    }
}
